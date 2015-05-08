tesseract =
function(..., init = TRUE)
{
  api = .Call("R_TessBaseAPI_new")

  if(init)
     Init(api)
  
  if(nargs() > 0)
     SetVariables(api, ...)  
  
  api
}

Init = 
function(api, lang = "eng")
{
  .Call("R_TessBaseAPI_Init", api, as.character(lang))
}

End =
function(api)
{
  .Call("R_TessBaseAPI_End", api)
}

SetVariables =
function(api, ..., .vars = sapply(list(...), as, "character"))
{
  .vars[ .vars == "FALSE" ] = "F"
  .vars[ .vars == "TRUE" ] = "T"  
    
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
  if(is.character(pix)) {
     SetInputName(api, pix)
     pix = pixRead(pix)
  }
  
  .Call("R_TessBaseAPI_SetImage", api, pix)
  pix
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
   level = as(level, "PageIteratorLevel")
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


VarTypes = c("i" = 1L, "int" = 1L, "integer" = 1L,
             "d" = 2L, "double" = 2L, "numeric" = 2L,
             "l" = 3L, "bool" = 3L, "logical" = 3L,
             "s" = 4L, "string" = 4L, "character" = 4L)

GetVariables =
function(api, var, type = NA)
{
  if(missing(var))
     return(PrintVariables(api))

if(FALSE) {  
  if(length(type) != length(var))
      type = rep(type, length = var)

  if(is.character(type)) {
     i =  pmatch(type, names(VarTypes))
     type = i
  }
}
  
  .Call("R_tesseract_GetVariable", api, as.character(var), rep(0L, length(var)))
}


IsValidWord =
function(api, word)
{
   .Call("R_tesseract_IsValidWord", api, as.character(word))
}


GetInputName =
function(api)
{
  .Call("R_tesseract_GetInputName", api)
}


GetDatapath =
function(api)
{
  .Call("R_tesseract_GetDatapath", api)
}

GetSourceYResolution =
function(api)
{
  .Call("R_tesseract_GetSourceYResolution", api)
}


PrintVariables =
function(api, file = tempfile())
{
  m = missing(file)
  if(m)
     on.exit(unlink(file))
  
  .Call("R_tesseract_PrintVariables", api, as.character(file))

  if(m) 
    readVars(file)
  
}

readVars =
function(f)
{
  d = read.table(f, sep = "\t", stringsAsFactors = FALSE)
  structure(d[,2], names = d[,1])
}


SetInputName =
function(api, name)
{
  .Call("R_tesseract_SetInputName", api, as.character(name))
}



setMethod("plot", "TessBaseAPI",
          function(x, y, level = "word", ...) {
              plot.OCR(api, level = level, ...)
          })


plot.OCR =
function(api, level = "word",
         ri = GetIterator(api),
         filename = GetInputName(api),
         img = readPNG(filename),
         bbox = lapply(ri, BoundingBox, level), ...)
{
    m = do.call(rbind, bbox)
    xr = range(m[, 1], m[,3])
    yr = range(m[, 2], m[,4])

    r = nrow(img)
    c = ncol(img)
    
    plot(0, type = "n", xlab = "", ylab = "", xlim = c(0, c), ylim = c(0, r), ...)    
    rasterImage(img, 0, 0, c, r)
    rect(m[,1], r - m[,2], m[,3], r - m[,4], border = "red")
    
    rect(min(m[,1]), r - min(m[,2]), max(m[,3]), r - max(m[,4]), border = "green")

    NULL
}
