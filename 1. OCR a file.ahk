; Img file ( bmp, dib, rle, jpg, jpeg, jpe, jfif, gif, tif, tiff, png )
MsgBox, % PaddleOCR("test_en.png")

; PDF file
MsgBox, % PaddleOCR("test.pdf")

; page 2
MsgBox, % PaddleOCR({pdf:"test.pdf", index:2})

; last page
MsgBox, % PaddleOCR({pdf:"test.pdf", index:-1})

#Include PaddleOCR\PaddleOCR.ahk