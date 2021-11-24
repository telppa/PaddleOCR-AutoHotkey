; Return all information including confidence and position.
; Because "get_all_info" is set, the return value is an object.
ret := PaddleOCR("test_en.png", {"get_all_info":1})
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

; Configs changes will affect all PaddleOCR() after that.
; So even if NO configs change here, all information will still be return.
ret := PaddleOCR("test_en.png")
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

#Include PaddleOCR\PaddleOCR.ahk