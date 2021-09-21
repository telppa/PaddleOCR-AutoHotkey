MsgBox,
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
  
How to switch language:
  Download and rename and overwrite the original file which in "PaddleOCR\Dll\inference".
  
    Multilingual OCR model.
    Overwrite "PaddleOCR\Dll\inference\ch_ppocr_mobile_v2.0_rec_infer"
    Overwrite "PaddleOCR\Dll\inference\ch_ppocr_server_v2.0_rec_infer"
      https://github.com/PaddlePaddle/PaddleOCR/blob/release/2.2/doc/doc_en/models_list_en.md
    
    Multilingual dict file.
    Overwrite "PaddleOCR\Dll\inference\ppocr_keys_v1.txt"
      https://github.com/PaddlePaddle/PaddleOCR/tree/release/2.2/ppocr/utils/dict
  
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

Another possibility is that your CPU is too old.
)