/*
author:    telppa（空）
version:   2021.09.05
*/
PaddleOCR(Image, Configs:="")
{
    static hModule, model, get_all_info, LastConfigs, DllPath := A_LineFile "\..\Dll"
    
    ; 校验运行版本
    if (A_PtrSize!=8)
    {
        MsgBox, 0x40010, , PaddleOCR must run on x64.
        ExitApp
    }
    
    ; 校验路径中是否包含空白符（例如空格）
    ; if (RegExMatch(A_LineFile, "\s"))
    ; {
        ; MsgBox, 0x40010, , Please do not include whitespace in the path.
        ; ExitApp
    ; }
    
    ; 首次运行或 Configs 传入值则生成配置文件
    if (!hModule or IsObject(Configs))
    {
        ; 支持的 Configs 选项
        model                        := NonNull_Ret(Configs.model                       , model="" ? "server" : model)
        get_all_info                 := NonNull_Ret(Configs.get_all_info                , 0)
        
        use_gpu                      := NonNull_Ret(Configs.use_gpu                     , 0)
        gpu_id                       := NonNull_Ret(Configs.gpu_id                      , 0)
        gpu_mem                      := NonNull_Ret(Configs.gpu_mem                     , 4000)
        cpu_math_library_num_threads := NonNull_Ret(Configs.cpu_math_library_num_threads, 10)
        use_mkldnn                   := NonNull_Ret(Configs.use_mkldnn                  , 0)
        
        max_side_len                 := NonNull_Ret(Configs.max_side_len                , 960)
        det_db_thresh                := NonNull_Ret(Configs.det_db_thresh               , 0.5)
        det_db_box_thresh            := NonNull_Ret(Configs.det_db_box_thresh           , 0.5)
        det_db_unclip_ratio          := NonNull_Ret(Configs.det_db_unclip_ratio         , 2.2)
        use_polygon_score            := NonNull_Ret(Configs.use_polygon_score           , 1)
        
        use_angle_cls                := NonNull_Ret(Configs.use_angle_cls               , 0)
        cls_thresh                   := NonNull_Ret(Configs.cls_thresh                  , 0.9)
        
        visualize                    := NonNull_Ret(Configs.visualize                   , 0)
        
        use_tensorrt                 := NonNull_Ret(Configs.use_tensorrt                , 0)
        use_fp16                     := NonNull_Ret(Configs.use_fp16                    , 0)
        
        ; 使用更快或更准的模型
        model          := (model="fast" or model="mobile") ? "mobile" : "server"
        det_model_dir  := DllPath "\inference\ch_ppocr_" model "_v2.0_det_infer\"
        cls_model_dir  := DllPath "\inference\ch_ppocr_mobile_v2.0_cls_infer\"
        rec_model_dir  := DllPath "\inference\ch_ppocr_" model "_v2.0_rec_infer\"
        char_list_file := DllPath "\inference\ppocr_keys_v1.txt"
        
        ; config.txt 模板
        template=
        (LTrim
        use_gpu %use_gpu%                                             # 是否使用 GPU 。1表示使用，0表示不使用。
        gpu_id  %gpu_id%                                              # GPU id 。使用 GPU 时有效。
        gpu_mem  %gpu_mem%                                            # 申请的 GPU 内存。
        cpu_math_library_num_threads  %cpu_math_library_num_threads%  # CPU 预测时的线程数。在机器核数充足的情况下，该值越大，预测速度越快。
        use_mkldnn %use_mkldnn%                                       # 是否使用 mkldnn 库（ CPU 加速用）。1表示使用，0表示不使用。

        max_side_len  %max_side_len%                                  # 输入图像长宽大于 n 时，等比例缩放图像，使得图像最长边为 n 。
        det_db_thresh  %det_db_thresh%                                # 用于过滤 DB 预测的二值化图像。设置为 0. - 0.3 对结果影响不明显。
        det_db_box_thresh  %det_db_box_thresh%                        # DB 后处理过滤 box 的阈值。如果检测存在漏框情况，可酌情减小。
        det_db_unclip_ratio  %det_db_unclip_ratio%                    # 表示文本框的紧致程度。越小则文本框更靠近文本。
        use_polygon_score %use_polygon_score%                         # 是否使用多边形框计算 bbox score 。0表示使用矩形框计算。矩形框计算速度更快，多边形框对弯曲文本区域计算更准确。
        det_model_dir  %det_model_dir%                                # 检测模型的位置。

        use_angle_cls %use_angle_cls%                                 # 是否使用方向分类器。1表示使用，0表示不使用。
        cls_model_dir  %cls_model_dir%                                # 方向分类器的位置。
        cls_thresh  %cls_thresh%                                      # 方向分类器的得分阈值。

        rec_model_dir  %rec_model_dir%                                # 识别模型的位置。
        char_list_file  %char_list_file%                              # 字典文件的位置。

        visualize %visualize%                                         # 是否对结果进行可视化。为1时，会在主代码文件夹下保存文件名为 ocr_vis.png 的可视化预测结果。

        use_tensorrt %use_tensorrt%                                   # 是否使用 tensorrt 。
        use_fp16 %use_fp16%                                           # 是否使用 fp16 。
        )
        if (template!=LastConfigs)
        {
            FileDelete, %DllPath%\config.txt
            FileAppend, %template%, %DllPath%\config.txt
            LastConfigs := template
            NeedToInit  := 1
        }
    }
    
    ; 搜索 Dll 所依赖的子 Dll 默认位置是在主代码运行时的目录（此目录通过 SetWorkingDir 更改无效）。
    ; 所以如果主代码和 “有子依赖的 Dll 文件” 不在同一目录，那么就需要指定位置，否则会报错找不到 Dll 。
    ; 3种方法。
    ; 1是 SetDllDirectory 。
    ; 2是 LoadLibraryEx 使用绝对路径并加 LOAD_WITH_ALTERED_SEARCH_PATH 选项。
    ; 3是 提前把所有子依赖 Dll 通过 LoadLibrary 加载一遍。
    ; 由于 LoadLibrary 的根据文件名避免重复加载特性。
    ; 例如 LoadLibrary("c:\a.dll") 再 LoadLibrary("d:\somedir\a.dll") 得到的还是 c 盘里的 Dll 。
    ; 所以这里排除方法3，使用方法1。
    if (!hModule)
    {
        DllCall("SetDllDirectory", "str", DllPath)
        hModule := DllCall("LoadLibrary", "str", DllPath "\PaddleOCR.dll")
    }
    ; 设置变更需要重新初始化
    if (NeedToInit)
    {
        DllCall("PaddleOCR\destroy")
        DllCall("PaddleOCR\init", "astr", DllPath "\config.txt", "cdecl int")
        FileDelete, %DllPath%\config.txt
    }
    
    ; 加载图片到内存
    pStream := ImagePutStream(Image)
    DllCall("ole32\GetHGlobalFromStream", "ptr", pStream, "ptr*", hMemory)
    pMemory := DllCall("GlobalLock", "ptr", hMemory, "ptr")
    pSize   := DllCall("GlobalSize", "ptr", hMemory, "uptr")
    
    ; 是否返回包括识别到的内容、置信度和坐标在内的全部信息（ JSON 格式）
    if (get_all_info)
        str := DllCall("PaddleOCR\ocr_from_binary", "ptr", pMemory, "int", pSize, "int", 1, "str")
    else
        str := DllCall("PaddleOCR\ocr_from_binary", "ptr", pMemory, "int", pSize, "str")
    
    ; 释放内存资源
    DllCall("GlobalUnlock", "ptr", hMemory)
    DllCall("GlobalFree", "ptr", hMemory)
    ObjRelease(pStream)
    
    return, str
}

#Include %A_LineFile%\..\Lib\ImagePut.ahk
#Include %A_LineFile%\..\Lib\NonNull.ahk

/* PaddleOCR.dll 说明 by 天黑请闭眼
PaddleOCR导出函数
```cpp
// 释放加载的模型
void destroy();

// 读取配置字符串，根据配置文件加载模型，配置文件ansi编码
int load_config(const char* config);

// 读取配置文件，根据配置文件加载模型，配置文件ansi编码
int load_config_file(const char* path);

// ocr本地文件，allinfo 为 TRUE 时，返回JSON格式，包含识别结果、置信度、位置信息
const wchar_t* ocr_from_file(const char* path, BOOL allinfo = FALSE);

// ocr图片的二进制
const wchar_t* ocr_from_binary(const char* data, UINT size, BOOL allinfo = FALSE);
```

**注意**
- 需要以下dll文件: 
    [paddle预测库](https://paddle-inference.readthedocs.io/en/latest/user_guides/download_lib.html)(libiomp5md, mklml, mkldnn, paddle_inference)
    [opencv](https://sourceforge.net/projects/opencvlibrary/files/4.5.2/opencv-4.5.2-vc14_vc15.exe/download)(opencv_world452)
- 需要识别模型:
    [OCR模型列表](https://gitee.com/paddlepaddle/PaddleOCR/blob/release/2.1/doc/doc_ch/models_list.md)
*/