tesseract =
function(image = character(), pageSegMode = integer(), lang = "eng", datapath = NA, ..., opts = list(...), init = TRUE)
{
  api = .Call("R_TessBaseAPI_new")

  if(length(pageSegMode))
      SetPageSegMode(api, pageSegMode)

  if(!init && ((length(image) && file.exists(image)) || length(opts))) {
      warning("forcing a call to Init() since setting the image and/or variables.")
      init = TRUE
  }
      
  if(init)
     Init(api, lang, datapath)

  if(nargs() > 0)
     SetVariables(api, opts = opts)  
  
  if(length(image))
     SetImage(api, image)
  
  api
}

Init = 
function(api, lang = "eng", datapath = NA)
{
  if(!is.na(datapath) && (!file.exists(datapath) || !file.info(datapath)[1, "isdir"])) 
      stop("No such directory ", datapath)

   
  ok = .Call("R_TessBaseAPI_Init", api, as.character(lang), as.character(datapath))
  if(!ok) 
      stop(mkError("Error calling Init() for the tesseract object", "TesseractInitFailure"))

  TRUE
}

End =
function(api)
{
  .Call("R_TessBaseAPI_End", api)
}

SetVariables =
function(api, ..., opts = list(...))
{
  .vars = sapply(opts, as, "character")
  .vars[ .vars == "FALSE" ] = "F"
  .vars[ .vars == "TRUE" ] = "T"  
    
  .Call("R_TessBaseAPI_SetVariables", api, .vars)
}

pixRead = 
function(filename, ...)
{
   filename = path.expand(filename)
   if(!file.exists(filename))
      stop("no such file ",  filename)

   .Call("R_pixRead", filename)
}

SetImage = 
function(api, pix)
{
  if(is.character(pix)) {
     if(!file.exists(pix))
        stop("No such file ", pix)
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
function(api, recognize = TRUE)
{
   ans = .Call("R_TessBaseAPI_GetIterator", api)
   if(is.null(ans)) {
       if(recognize) {
           Recognize(api)
           return(GetIterator(api))
       } else {
         e = simpleError("Did you call Recognize()")
         class(e) = c("TesseractRecognizeNotCalled", class(e))
         stop(e)
       }
   }
   ans
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

setMethod("lapply", "TesseractBaseAPI",
           function(X, FUN, level = "word", ...) {
               lapply(as(X, "ResultIterator"), FUN, level, ...)
           })

setAs("TesseractBaseAPI", "ResultIterator",
        function(from) {
              # Do we need to ensure Recognize() has been called ?
            GetIterator(from)
        })
      
    


BoundingBoxes =
function(ri, level = 3L)
{
   m = lapply(as(ri, "ResultIterator"), BoundingBox, level = level)
   ans = do.call(rbind, m)
   colnames(ans) = c("bottom.left.x", "bottom.left.y", "top.right.x", "top.right.y")
#   rownames(ans) = names(m)
   ans
}

BoundingBox = 
function(ri, level = 3L)
{
  ri = as(ri, "ResultIterator")
#  if(!is(ri, "ResultIterator"))
#    stop("need a result iterator")

  #!!! Put names on these.
  .Call("R_ResultIterator_BoundingBox", ri, as.integer(level))
}

Confidence = 
function(ri, level = 3L)
{
  ri = as(ri, "ResultIterator")    
#  if(!is(ri, "ResultIterator"))
#    stop("need a result iterator")

  .Call("R_ResultIterator_Confidence", ri, as.integer(level))
}




setGeneric("getConfidences",
           function(obj, level = 3L, ...)
             standardGeneric("getConfidences"))

setMethod("getConfidences",
          "TesseractBaseAPI",
          function(obj, level = 3L, ...) {
              .Call("R_TesseractBaseAPI_getConfidences", obj, as.integer(level))
          })

setMethod("getConfidences",
           "character",
          function(obj, level = 3L, ...) {
              ts = tesseract(obj)
              Recognize(ts)
              getConfidences(ts, level, ...)
          })


setGeneric("getBoxes",
           function(obj, level = 3L, ...)
             standardGeneric("getBoxes"))

setMethod("getBoxes",
          "TesseractBaseAPI",
          function(obj, level = 3L, ...) {
              ans = .Call("R_TesseractBaseAPI_getBoundingBoxes", obj, as.integer(level))
              m = do.call(rbind, ans)
              rownames(m) = names(ans)
              colnames(m) = c("confidence", "left", "bottom", "right", "top") #XXXX
              m[, 2:5]  # still numeric! Change to integer.  Or leave the confidence in.
          })

setMethod("getBoxes",
           "character",
          function(obj, level = 3L, ...) {
              ts = tesseract(obj)
              Recognize(ts) # Want to avoid doing this twice if possible
              getBoxes(ts, level, ...)
          })





GetText = GetUTF8Text = 
function(ri, level = 3L)
{
   ri = as(ri, "ResultIterator")
#  if(!is(ri, "ResultIterator"))
#    stop("need a result iterator")

  .Call("R_ResultIterator_GetUTF8Text", ri, as.integer(level))
}


Clear = 
function(api)
{
  .Call("R_tesseract_Clear", api)
}

ClearAdaptiveClassifier = 
function(api)
{
  .Call("R_tesseract_ClearAdaptiveClassifier", api)
}



SetRectangle = 
function(api, ..., dims = sapply(list(...), as.integer))
{
  dims = as.integer(dims)
  if(length(dims) < 4)
    stop("incorrect number of dimensions for rectangle")
  
  .Call("R_tesseract_SetRectangle", api, dims)
}

SetSourceResolution =
function(api, ppi)
{
  .Call("R_tesseract_SetSourceResolution", api, as.integer(ppi))
}

ReadConfigFile = 
function(api, files, ok = FALSE)
{
   ff = path.expand(files)
   if(!ok && !all(ok <- file.exists(ff)))
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
function(api, var)  # , type = NA
{
  if(missing(var))
     return(GetVariables(api, names(PrintVariables(api))))

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

GetInputImage = GetImage =
function(api, asArray = TRUE)
{
  .Call("R_TessBaseAPI_GetInputImage", api, as.logical(asArray))
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
function(api = tesseract(), asDataFrame = FALSE, file = tempfile())
{
  m = missing(file)
  if(m)
     on.exit(unlink(file))
  
  .Call("R_tesseract_PrintVariables", api, as.character(file))

  if(m) 
    readVars(file, asDataFrame)
  
}

readVars =
function(f, asDataFrame = FALSE)
{
  d = read.table(f, sep = "\t", stringsAsFactors = FALSE, quote = '', comment.char = '')
  if(asDataFrame)
     structure(d, names = c("optionName", "value", "info"))
  else
     structure(d[,2], names = d[,1])
}


SetInputName =
function(api, name)
{
  checkImageTypeSupported(name)    
  .Call("R_tesseract_SetInputName", api, as.character(name))
}




GetAlternatives =
function(ri, ...)
{
    .Call("R_getAlternatives", as(ri, "ResultIterator"))
}


SetPageSegMode =
function(api, mode)
{
    .Call("R_TessBaseAPI_SetPageSegMode", as(api, "TesseractBaseAPI"), as(mode, "PageSegMode"))
}

GetPageSegMode =
function(api)
{
    .Call("R_TessBaseAPI_GetPageSegMode", as(api, "TesseractBaseAPI"))
}


setGeneric("getImageDims", function(obj, ...) standardGeneric("getImageDims"))

setMethod("getImageDims", "TesseractBaseAPI",
          function(obj, ...) {
              ans = .Call("R_TessBaseAPI_GetImageDimensions", obj)
              names(ans) = c("height", "width", "depth")
              ans
          })

setMethod("getImageDims", "Pix",
          function(obj, ...) {
              ans = .Call("R_Pix_GetDimensions", obj)
              names(ans) = c("height", "width", "depth")
              ans
          })

setGeneric("getImageInfo", function(obj, ...) standardGeneric("getImageInfo"))

setMethod("getImageInfo", "TesseractBaseAPI",
          function(obj, ...) {
              ans = .Call("R_TessBaseAPI_GetImageInfo", obj)
              names(ans) = c("samplesPerPixel", "xres", "yres", "informat", "colorDepth")  # from .../include/leptonica/pix.h
              ans
          })
setMethod("getImageInfo", "Pix",
          function(obj, ...) {
              ans = .Call("R_Pix_GetInfo", obj)
              names(ans) = c("samplesPerPixel", "xres", "yres", "informat", "colorDepth")  # from .../include/leptonica/pix.h
              ans
          })

   
