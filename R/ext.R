tesseract =
function(...)
{
  .Call("R_TessBaseAPI_new")
}

Init = 
function(api, lang = "eng")
{
  .Call("R_TessBaseAPI_Init", api, as.character(lang))
}

setVariables =
function(api, ..., .vars = sapply(list(...), as, "character"))
{
  .Call("R_TessBaseAPI_SetVariables", api, as(.vars, "character"))
}

pixRead = 
function(filename, ...)
{
   filename = path.expand(filename)
   if(!file.exists(filename))
      stop("no such file ",  file)

   .Call("R_pixRead", filename)
}

SetImage = 
function(api, pix)
{
  .Call("R_TessBaseAPI_SetImage", api, pix)
}

Recognize =
function(api)
{
   .Call("R_TessBaseAPI_Recognize", api)
}


GetIterator =
function(api)
{
   .Call("R_TessBaseAPI_GetIterator", api)
}


lapply.ResultIterator =
function(X, FUN, level, ...) 
{
#   level = as("level", "PageIteratorLevel")
   if(is.function(FUN)) {
      e = substitute(foo(ri, level), 
                          list(foo = FUN, ri = X, level = level))
   } else if(is.character(FUN))
       e = getNativeSymbolInfo(as.character(FUN))
   else
       e = FUN
  
   if(is(e, "NativeSymbolInfo"))
       e = e$address

   .Call("R_ResultIterator_lapply", X, level, e)
}

if(!isGeneric("lapply"))
  setGeneric("lapply",
             function(X, FUN, ...)
                standardGeneric("lapply"))

setMethod("lapply", "ResultIterator", lapply.ResultIterator)




BoundingBox = 
function(ri, level = 3L)
{
  if(!is(ri, "ResultIterator"))
    stop("need a result iterator")

  .Call("R_ResultIterator_BoundingBox", ri, as.integer(level))
}

Confidence = 
function(ri, level = 3L)
{
  if(!is(ri, "ResultIterator"))
    stop("need a result iterator")

  .Call("R_ResultIterator_Confidence", ri, as.integer(level))
}

GetText = GetUTF8Text = 
function(ri, level = 3L)
{
  if(!is(ri, "ResultIterator"))
    stop("need a result iterator")

  .Call("R_ResultIterator_GetUTF8Text", ri, as.integer(level))
}


Clear = 
function(api)
{
  .Call("R_tesseract_Clear", api)
}


SetRectangle = 
function(api, ..., dims = sapply(list(...), as.integer))
{
  .Call("R_tesseract_SetRectangle", api, dims)
}

SetSourceResolution =
function(api, ppi)
{
  .Call("R_tesseract_SetSourceResolution", api, as.integer(ppi))
}

ReadConfigFile = 
function(api, files)
{
   ff = path.expand(files)
   if(!all(ok <- file.exists(f)))
      stop("some files don't exist: ", paste( ff[!ok], collapse = ", "))

   .Call("R_tesseract_ReadConfigFile", api, ff)
}

GetInitLanguages = 
function(api)
{
  .Call("R_tesseract_GetInitLanguagesAsString", api)
}
