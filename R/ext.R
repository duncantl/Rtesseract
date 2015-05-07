tesseract =
function(...)
{
  .Call("R_TessBaseAPI_new")
}

Init = 
function(...)
{
  .Call("R_TessBaseAPI_Init")
}

setVariables =
function(api, ..., .vars = sapply(list(...), as, "character"))
{
  .Call("R_TessBaseAPI_SetVariables", api, as(.vars, "character"))
}