﻿MsgBox,
(
Requires:
  vc2015-vc2017 x64 runtime library.
  
Usage:
  PaddleOCR(Image, Configs)
  
  Image
    Can be an image of almost any format.
    For details see: https://github.com/iseahound/ImagePut
  
  Configs
    Below are the supported settings and their default values.
    Some of them will affect the recognition result, all of them can be omitted.
    See the examples or souce code for the meaning.
    {
      "model":                        "server"
      "get_all_info":                 0
      "visualize":                    0
      "cpu_math_library_num_threads": 10
      "use_mkldnn":                   1
      "max_side_len":                 960
      "det_db_thresh":                0.5
      "det_db_box_thresh":            0.5
      "det_db_unclip_ratio":          2.2
      "use_polygon_score":            1
      "use_angle_cls":                0
      "cls_thresh":                   0.9
    }
  
How to switch language:
  Download recognition model.
    https://github.com/PaddlePaddle/PaddleOCR/blob/release/2.3/doc/doc_en/models_list_en.md
  Overwrite "PaddleOCR\Dll\inference\mobile_rec"
  Overwrite "PaddleOCR\Dll\inference\server_rec"
  
  Download dict file.
    https://github.com/PaddlePaddle/PaddleOCR/blob/release/2.3/doc/doc_en/models_list_en.md
  Rename and overwrite "PaddleOCR\Dll\inference\dict.txt"
  
Thanks:
  PaddleOCR
    https://github.com/PaddlePaddle/PaddleOCR
  
  PaddleOCR Dll
    Made by thqby. (https://gitee.com/orz707)
    He release it in QQ Group.
  
  ImagePut
    Made by iseahound.
    https://github.com/iseahound/ImagePut
)

MsgBox,
(
If you wait more than 1 minute without seeing OCR results, the most likely reason is that the vc2015-2017 x64 runtime library is missing.

The second possibility is that your CPU is too old.

Lastly, it could be that some dependent DLL files are missing from the lite system.
)