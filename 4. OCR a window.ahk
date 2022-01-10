; All WinTitle format is supported. Affected by SetTitleMatchMode.
; Run Paint
Run, mspaint.exe
Sleep, 1000

; by title
MsgBox, % PaddleOCR("Untitled - Paint")

; by ahk_class
MsgBox, % PaddleOCR("ahk_class MSPaintApp")

; by ahk_id
; MsgBox, % PaddleOCR("ahk_id 0x123abc")

; by ahk_exe
MsgBox, % PaddleOCR("ahk_exe mspaint.exe")

; by ahk_pid
; MsgBox, % PaddleOCR("ahk_pid 1234")

#Include PaddleOCR\PaddleOCR.ahk