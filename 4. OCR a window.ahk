Run, notepad.exe
Sleep, 1000
MsgBox, % PaddleOCR("ahk_exe notepad.exe")  ; All WinTitle format is supported. Affected by SetTitleMatchMode.

#Include PaddleOCR\PaddleOCR.ahk