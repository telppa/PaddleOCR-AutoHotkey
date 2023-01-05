; 1. Use Win + Shift + s to open snipping tool
; 2. Grab an area from the screen.

#Persistent
OnClipBoardChange("ScreenshotOnClipboard")

ScreenshotOnClipboard(ct) {
   ; Check for an image on clipboard
   if (ct != 2)
      return

   ; Wait for the screen to return to normal
   Sleep 500

   ; Copy text to clipboard
   MsgBox % A_Clipboard := PaddleOCR({clipboard: true})
}

#Include PaddleOCR\PaddleOCR.ahk