# PaddleOCR-AutoHotkey  
PaddleOCR AutoHotkey 版。  
  <br>
# 简介  
本项目是 AutoHotkey 语言（简称 AHK ）的函数库，用户仅需1行代码即可使用 PaddleOCR 的各种功能。  
  <br>
# 快速开始  
对于非 AHK 用户，下载 **[此版本](https://github.com/telppa/PaddleOCR-AutoHotkey/releases/download/v20220110/PaddleOCR-AutoHotkey_with_interpreter.zip)** 并运行其中的 `示例.exe` 即可。  
`示例.exe` 实际就是 AHK 的解释器，它负责解释并执行 `示例.ahk` 中的代码。  
  <br>
# 语法  
#### 识别本地图片（支持 bmp, dib, rle, jpg, jpeg, jpe, jfif, gif, tif, tiff, png ）  
* `PaddleOCR("test_zh.png")`  
  
#### 识别本地 PDF 文件  
* `PaddleOCR("test.pdf")`  
  
#### 识别本地 PDF 文件第2页  
* `PaddleOCR({pdf:"test.pdf", index:2})`  
  
#### 识别本地 PDF 文件最后1页  
* `PaddleOCR({pdf:"test.pdf", index:-1})`  
  
#### 根据坐标截屏并识别  
* `PaddleOCR([0, 0, 100, 200])`  
  
#### 识别所有显示器内容  
* `PaddleOCR(0)`  
  
#### 识别第1台显示器内容  
* `PaddleOCR(1)`  
  
#### 识别第2台显示器内容  
* `PaddleOCR(2)`  
  
#### 根据窗口标题识别一个程序界面（这里用的是画图窗口）  
* `PaddleOCR("无标题 - 画图")`  
  
#### 根据窗口类名识别  
* `PaddleOCR("ahk_class MSPaintApp")`  
  
#### 根据窗口句柄识别  
* `PaddleOCR("ahk_id 0x123abc")`  
  
#### 根据进程名识别  
* `PaddleOCR("ahk_exe mspaint.exe")`  
  
#### 根据进程 PID 识别  
* `PaddleOCR("ahk_pid 1234")`  
  
#### 识别剪贴板  
* `PaddleOCR(ClipboardAll)`  
  
#### 识别壁纸  
* `PaddleOCR("wallpaper")`  
  
#### 识别鼠标指针  
* `PaddleOCR(A_Cursor)`  
  
#### 识别 base64 编码后的图片  
* `PaddleOCR("iVBORw0KGgoAAAANSUhEUgAAAFAAAAAjCAMAAAA0eX3wAAAARVBMVEUdISXMzMyyfkUdYZmXYSWyzMw/frMdQ3/MmGPMsn8/ISV8sswdIWMdIUWXzMzMzLNfmMx8QyXMzJlfISWXfn+XmLOXmGNE0xoSAAAA5klEQVRIx+2SWQ6DMBBDk7ClK9Dt/ketmViyUBp+WqmqGn8gM8w8PFFcVdXfqvFhZY9n7338IBAaut8H9uPc42RaxyPyu32qL94osgKyGl8C70BM4wzgw6iXq3OnA54WS3YNxAR6MZoBEcn6VGiX+ZZ7ygrId36TNI8Y/Jc1MRVskBWQAW2dWARijIeIgvEJlBWQ/dy5lBDNeFhCNJJCmwN9UgFoY1yj2UqolZGQyoGkEDjR2gkEWQF52zaAXLa3QD4VIiC3LsgKmHYuEHVr6ePQpcgAD6DImlP3ZLZwbd5QBVZVfVVP8SYLFHfLLvoAAAAASUVORK5CYII=")`  
  
#### 识别网址（网址可对应图片、 PDF 、 base64 字符串等等上述提到过的全部内容，这里用的是百度的 logo ）  
* `PaddleOCR("https://www.baidu.com/img/flexible/logo/pc/result.png")`  
  <br>
# 进阶  
除上述基本使用外，本库还支持 **17项** 额外参数。  
以下仅演示部分额外参数的使用，完整参数请查看 `示例.ahk` 文件。  
  
#### 使用更快速但准确率不高的模型识别本地图片  
* `PaddleOCR("test_zh.png", {"model":"fast"})`  
  
#### 使用更快速但准确率不高的模型识别本地图片，返回包括置信度与坐标在内的全部信息，并生成可视化的识别结果
* `PaddleOCR("test_zh.png", {"model":"fast", "get_all_info":1, "visualize":1})`  
  <br>
# 更新日志  
#### 2022.01.10  
* Support OCR PDF file directly.  
* Fix a bug when set "get_all_info" to 1.  
* Add 4 examples.  
* Update all examples.  
* Update ImagePut.ahk to 1.5.1.  
  
#### 2021.11.24  
* When set "get_all_info" to 1, the return value is an object.  
* Fix a bug when set "get_all_info" to 1.  
* Update example 6 and 7.  
* Update ImagePut.ahk to 1.3.  
* Update JSON.ahk to cJSON.ahk.  
  
#### 2021.10.03  
* Update PaddleOCR.dll to 2.3.  
* Update detection model to ch_PP-OCRv2_det.  
* Update ImagePut.ahk to 1.2 beta.  
* Load configs no longer requires temporary file.  
* Rename dict file and model directories  
  <br>
# 感谢  
#### PaddleOCR  
* https://github.com/PaddlePaddle/PaddleOCR  
  
#### PaddleOCR Dll  
* Made by thqby. (https://gitee.com/orz707)  
* He release it in QQ Group.  
  
#### ImagePut  
* Made by iseahound.  
* https://github.com/iseahound/ImagePut  
