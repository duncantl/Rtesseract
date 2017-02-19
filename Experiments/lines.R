
do =
function(segLevel, pageLevel = "symbol", file = "inst/trainingSample/eng.tables.exp0.png")
{
  ts = tesseract(file)
  .Call("R_TessBaseAPI_SetPageSegMode", api, as.integer(segLevel))
  Recognize(ts)
  BoundingBoxes(api, pageLevel)
}
