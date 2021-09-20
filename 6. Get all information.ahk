; Return all information including confidence and position (JSON format)
MsgBox, % PaddleOCR("test_en.png", {"get_all_info":1})

; Configs changes will affect all PaddleOCR() after that.
; So even if NO configs change here, all information will still be return.
MsgBox, % PaddleOCR("test_en.png")

#Include PaddleOCR\PaddleOCR.ahk