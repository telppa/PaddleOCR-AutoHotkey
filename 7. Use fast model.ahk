; Use a faster but less accurate model to OCR local image and return all information including confidence and position (JSON format)
MsgBox, % PaddleOCR("test_en.png", {"model":"fast", "get_all_info":1})

; After changing any Configs setting, the settings who were not changed will revert to their default values.
; Because only the "model" setting is changed here, so "get_all_info" reverts to the default value of 0
; So only text information is returned.
MsgBox, % PaddleOCR("test_en.png", {"model":"server"})

#Include PaddleOCR\PaddleOCR.ahk