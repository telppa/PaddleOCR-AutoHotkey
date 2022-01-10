; Use a faster but less accurate model to OCR local image, return all information including confidence and position, generate visualization recognition results.
; Because "get_all_info" is set, so the return value is an object.
ret := PaddleOCR("test_en.png", {"model":"fast", "get_all_info":1, "visualize":1})
Run, ocr_vis.png  ; Show visualization recognition results
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

; After changing any Configs setting, the settings who were not changed will revert to their default values.
; Because only the "model" setting is changed here, so "get_all_info" and "visualize" reverts to the default value of 0.
; So only text information is returned.
MsgBox, % PaddleOCR("test_en.png", {"model":"server"})

#Include PaddleOCR\PaddleOCR.ahk