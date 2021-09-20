/*
依赖：
  vc2015-vc2017 x64 运行时库。
  
用法：
  PaddleOCR(Image, Configs)
  
  Image 可以是几乎任意形式的图片。
  具体可见：https://github.com/iseahound/ImagePut
  
  Configs 以下是支持的设置及其默认值。
  部分会影响识别结果，全部可以省略，具体含义看示例或翻代码。
  {
    "model":                        "server"
    "get_all_info":                 0
    "use_gpu":                      0
    "gpu_id":                       0
    "gpu_mem":                      4000
    "cpu_math_library_num_threads": 10
    "use_mkldnn":                   0
    "max_side_len":                 960
    "det_db_thresh":                0.5
    "det_db_box_thresh":            0.5
    "det_db_unclip_ratio":          2.2
    "use_polygon_score":            1
    "use_angle_cls":                0
    "cls_thresh":                   0.9
    "visualize":                    0
    "use_tensorrt":                 0
    "use_fp16":                     0
  }
  
感谢：
  PaddleOCR
    https://github.com/PaddlePaddle/PaddleOCR
  
  PaddleOCR Dll
    Made by thqby. (https://gitee.com/orz707)
    He release it in QQ Group.
  
  ImagePut
    Made by iseahound.
    https://github.com/iseahound/ImagePut
*/

MsgBox, 如果接下来等待超过1分钟都没有看到 OCR 结果，最大可能就是缺少 vc2015-2017 x64 运行时库。`n`n另一种可能是 CPU 太老。

; 识别本地图片
MsgBox, % PaddleOCR("test_zh.png")

; 识别网上图片（这里用的是百度的 logo ）
MsgBox, % PaddleOCR("https://www.baidu.com/img/flexible/logo/pc/result.png")

; 根据坐标截屏并识别
MsgBox, % PaddleOCR([0,0,100,200])

; 识别一个程序界面（这里用的是记事本窗口）
Run, notepad.exe
Sleep, 1000
MsgBox, % PaddleOCR("ahk_exe notepad.exe")  ; WinTitle 格式都支持。受 SetTitleMatchMode 影响

; 识别剪贴板
; MsgBox, % PaddleOCR(ClipboardAll)

; 识别本地图片并返回包括置信度与坐标在内的全部信息（ JSON 格式）
; 注意：更改 Configs 后，之后的识别将继承新的 Configs 。
MsgBox, % PaddleOCR("test_zh.png", {"get_all_info":1})

; 因为上一个识别更改了 Configs ，所以这里即使不做额外设置依然会返回全部信息。
MsgBox, % PaddleOCR("test_zh.png")

; 使用更快速但准确率不高的模型识别本地图片并返回包括置信度与坐标在内的全部信息（ JSON 格式）
MsgBox, % PaddleOCR("test_zh.png", {"model":"fast", "get_all_info":1})

; 注意：更改任意 Configs 设置后，没有被更改的设置将恢复默认值。
; 因为这里只改了 model ，所以 get_all_info 将恢复默认值 0，所以只返回文本信息。
MsgBox, % PaddleOCR("test_zh.png", {"model":"server"})

MsgBox, 演示完成!

#Include PaddleOCR\PaddleOCR.ahk