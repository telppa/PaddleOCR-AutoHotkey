/*
依赖：
  vc2015-vc2017 x64 运行时库。
  
用法：
  PaddleOCR(Image, Configs)
  
  Image
    可以是几乎任意形式的图片。
    具体可见：https://github.com/iseahound/ImagePut
  
  Configs
    以下是支持的设置及其默认值。
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

; 识别本地图片（支持 bmp, dib, rle, jpg, jpeg, jpe, jfif, gif, tif, tiff, png ）
MsgBox, % PaddleOCR("test_zh.png")

; 识别本地 PDF 文件
MsgBox, % PaddleOCR("test.pdf")

; 识别本地 PDF 文件第2页
MsgBox, % PaddleOCR({pdf:"test.pdf", index:2})

; 识别本地 PDF 文件最后1页
MsgBox, % PaddleOCR({pdf:"test.pdf", index:-1})

; 根据坐标截屏并识别
MsgBox, % PaddleOCR([0, 0, 100, 200])

; 识别所有显示器内容
MsgBox, % PaddleOCR(0)

; 识别第1台显示器内容
MsgBox, % PaddleOCR(1)

; 识别第2台显示器内容
; MsgBox, % PaddleOCR(2)

; 启动画图
Run, mspaint.exe
Sleep, 1000

; 识别一个程序界面， WinTitle 格式都支持，受 SetTitleMatchMode 影响。
; 根据窗口标题识别一个程序界面（这里用的是画图窗口）
MsgBox, % PaddleOCR("无标题 - 画图")

; 根据窗口类名识别
MsgBox, % PaddleOCR("ahk_class MSPaintApp")

; 根据窗口句柄识别
; MsgBox, % PaddleOCR("ahk_id 0x123abc")

; 根据进程名识别
MsgBox, % PaddleOCR("ahk_exe mspaint.exe")

; 根据进程 PID 识别
; MsgBox, % PaddleOCR("ahk_pid 1234")

; 识别剪贴板
; MsgBox, % PaddleOCR(ClipboardAll)

; 识别壁纸
MsgBox, % PaddleOCR("wallpaper")

; 识别鼠标指针
MsgBox, % PaddleOCR(A_Cursor)

; 识别 base64 编码后的图片
MsgBox, % PaddleOCR("iVBORw0KGgoAAAANSUhEUgAAAFAAAAAjCAMAAAA0eX3wAAAARVBMVEUdISXMzMyyfkUdYZmXYSWyzMw/frMdQ3/MmGPMsn8/ISV8sswdIWMdIUWXzMzMzLNfmMx8QyXMzJlfISWXfn+XmLOXmGNE0xoSAAAA5klEQVRIx+2SWQ6DMBBDk7ClK9Dt/ketmViyUBp+WqmqGn8gM8w8PFFcVdXfqvFhZY9n7338IBAaut8H9uPc42RaxyPyu32qL94osgKyGl8C70BM4wzgw6iXq3OnA54WS3YNxAR6MZoBEcn6VGiX+ZZ7ygrId36TNI8Y/Jc1MRVskBWQAW2dWARijIeIgvEJlBWQ/dy5lBDNeFhCNJJCmwN9UgFoY1yj2UqolZGQyoGkEDjR2gkEWQF52zaAXLa3QD4VIiC3LsgKmHYuEHVr6ePQpcgAD6DImlP3ZLZwbd5QBVZVfVVP8SYLFHfLLvoAAAAASUVORK5CYII=")

; 识别网址（网址可对应图片、 PDF 、 base64 字符串等等上述提到过的全部内容，这里用的是百度的 logo ）
MsgBox, % PaddleOCR("https://www.baidu.com/img/flexible/logo/pc/result.png")

; 识别本地图片并返回包括置信度与坐标在内的全部信息。
; 因为设置了 get_all_info ，所以返回值是一个对象。
ret := PaddleOCR("test_zh.png", {"get_all_info":1})
for k, v in ret
{
  words := v.words
  score := v.score
  x1 := v.range.1.1, y1 := v.range.1.2
  x2 := v.range.2.1, y2 := v.range.2.2
  x3 := v.range.3.1, y3 := v.range.3.2
  x4 := v.range.4.1, y4 := v.range.4.2
  MsgBox, 
  (Ltrim
  words:`t%words%
  score:`t%score%
  x1,y1:`t%x1%,%y1%
  x2,y2:`t%x2%,%y2%
  x3,y3:`t%x3%,%y3%
  x4,y4:`t%x4%,%y4%
  )
}

; 注意：更改 Configs 后，之后的识别将继承新的 Configs 。
; 因为上一个识别更改了 Configs ，所以这里即使不做额外设置依然会返回全部信息。
ret := PaddleOCR("test_zh.png")
for k, v in ret
{
  words := v.words
  score := v.score
  x1 := v.range.1.1, y1 := v.range.1.2
  x2 := v.range.2.1, y2 := v.range.2.2
  x3 := v.range.3.1, y3 := v.range.3.2
  x4 := v.range.4.1, y4 := v.range.4.2
  MsgBox, 
  (Ltrim
  words:`t%words%
  score:`t%score%
  x1,y1:`t%x1%,%y1%
  x2,y2:`t%x2%,%y2%
  x3,y3:`t%x3%,%y3%
  x4,y4:`t%x4%,%y4%
  )
}

; 使用更快速但准确率不高的模型识别本地图片，返回包括置信度与坐标在内的全部信息，并生成可视化的识别结果
; 因为设置了 get_all_info ，所以返回值是一个对象。
ret := PaddleOCR("test_zh.png", {"model":"fast", "get_all_info":1, "visualize":1})
Run, ocr_vis.png  ; 显示可视化的识别结果
for k, v in ret
{
  words := v.words
  score := v.score
  x1 := v.range.1.1, y1 := v.range.1.2
  x2 := v.range.2.1, y2 := v.range.2.2
  x3 := v.range.3.1, y3 := v.range.3.2
  x4 := v.range.4.1, y4 := v.range.4.2
  MsgBox, 
  (Ltrim
  words:`t%words%
  score:`t%score%
  x1,y1:`t%x1%,%y1%
  x2,y2:`t%x2%,%y2%
  x3,y3:`t%x3%,%y3%
  x4,y4:`t%x4%,%y4%
  )
}

; 注意：更改部分 Configs 设置后，没有被更改的设置将恢复默认值。
; 因为这里只改了 model ，所以 get_all_info 与 visualize 都将恢复默认值 0，所以只返回文本信息。
MsgBox, % PaddleOCR("test_zh.png", {"model":"server"})

MsgBox, 演示完成!

#Include PaddleOCR\PaddleOCR.ahk