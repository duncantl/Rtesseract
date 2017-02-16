tesseract =
function(image = character(), pageSegMode = integer(), lang = "eng", datapath = NA,
         configs = character(), vars = character(), engineMode = OEM_DEFAULT, debugOnly = FALSE,
         ..., opts = list(...), init = TRUE)
{
  api = .Call("R_TessBaseAPI_new")

  if(!init && ((length(image) && file.exists(image)) || length(opts))) {
     warning("forcing a call to Init() since setting the image and/or variables.")
     init = TRUE
  }
      
  if(init)
     Init(api, lang, datapath = datapath, configs = configs, vars = vars, engineMode = engineMode, debugOnly = debugOnly)

  if(length(pageSegMode))  # Make certain this happens after Init() as the C++ Init() resets PageSegMode
      SetPageSegMode(api, pageSegMode)
  
  if(nargs() > 0)
     SetVariables(api, opts = opts)  
  
  if(length(image))
     SetImage(api, image)
  
  api
}

Init = 
function(api, lang = "eng", configs = character(), vars = character(), datapath = NA, engineMode = OEM_DEFAULT, debugOnly = FALSE, force2 = FALSE)
{
  if(!is.na(datapath) && (!file.exists(datapath) || !file.info(datapath)[1, "isdir"])) 
      stop("No such directory ", datapath)

  if(length(configs) == 0 && length(vars) == 0 && engineMode == OEM_DEFAULT && !force2) # so nothing special
     ok = .Call("R_TessBaseAPI_Init", as(api, "TesseractBaseAPI"), as.character(lang), as.character(datapath))
  else
     ok = .Call("R_TessBaseAPI_Init2", as(api, "TesseractBaseAPI"), as.character(lang), as.character(datapath),
                     as(engineMode, "OcrEngineMode"), as.character(configs), as.character(vars), as.logical(debugOnly))      
  if(!ok) 
      stop(mkError("Error calling Init() for the tesseract object", "TesseractInitFailure"))

  TRUE
}

End =
function(api)
{
  .Call("R_TessBaseAPI_End", as(api, "TesseractBaseAPI"))
}

SetVariables =
function(api, ..., opts = list(...))
{
  .vars = sapply(opts, as, "character")
  .vars[ .vars == "FALSE" ] = "F"
  .vars[ .vars == "TRUE" ] = "T"  
    
  .Call("R_TessBaseAPI_SetVariables", as(api, "TesseractBaseAPI"),  .vars)
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
     filename = pix
     pix = pixRead(pix)
      # Do this second in case pixRead() fails.
     SetInputName(api, filename, load = FALSE)
  }
  
  .Call("R_TessBaseAPI_SetImage", as(api, "TesseractBaseAPI"), pix)
  pix
}

Recognize =
function(api)
{
   .Call("R_TessBaseAPI_Recognize", as(api, "TesseractBaseAPI"))
}


GetIterator =
function(api, recognize = TRUE)
{
   ans = .Call("R_TessBaseAPI_GetIterator", as(api, "TesseractBaseAPI"))
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
    #
    # see getBoxes() instead.
    #
function(ri, level = 3L)
{
   m = lapply(as(ri, "ResultIterator"), BoundingBox, level = level)
   ans = do.call(rbind, m)
   colnames(ans) = c("bottom.left.x", "bottom.left.y", "top.right.x", "top.right.y")
#   rownames(ans) = names(m)
   ans
}

BoundingBox =
    # Retire this - getBoxes()
function(ri, level = 3L)
{
  ri = as(ri, "ResultIterator")

  #!!! Put names on these.
  .Call("R_ResultIterator_BoundingBox", ri, as(level, "PageIteratorLevel"))
}

Confidence = 
function(ri, level = 3L)
{
  ri = as(ri, "ResultIterator")    

  .Call("R_ResultIterator_Confidence", ri, as(level, "PageIteratorLevel"))
}

GetText = GetUTF8Text =
    # Justs gets one
function(ri, level = 3L)
{
   ri = as(ri, "ResultIterator")

  .Call("R_ResultIterator_GetUTF8Text", ri, as(level, "PageIteratorLevel"))
}


getText =
function(obj, level = 3L, ...)
{
  names(getConfidences(obj, level, ...))
}



setGeneric("getAlternatives",
           function(obj, level = 3L, ...)
             standardGeneric("getAlternatives"))

setMethod("getAlternatives",
          "TesseractBaseAPI",
          function(obj, level = 3L, ...) {
            .Call("R_getAllAlternatives", obj, as(level, "PageIteratorLevel"))
          })


setMethod("getAlternatives",
          "ResultIterator",
          function(obj, level = 3L, ...) {
            .Call("R_Current_getAlternatives", obj, as(level, "PageIteratorLevel"))
          })


setMethod("getAlternatives",
           "character",
          function(obj, level = 3L, ...) {
              ts = tesseract(obj, ...)
              Recognize(ts)
              getAlternatives(ts, level)
          })

setMethod("getAlternatives",
           "Pix",
          function(obj, level = 3L, ...) {
              ts = tesseract(...)
              SetImage(ts, obj)              
              Recognize(ts)
              getAlternatives(ts, level)
          })

setGeneric("getConfidences",
           function(obj, level = 3L, ...)
             standardGeneric("getConfidences"))

setMethod("getConfidences",
          "Pix",
          function(obj, level = 3L, ...) {
              api = tesseract(...)
              SetImage(api, obj)
              getConfidences(api, level)
          })

setMethod("getConfidences",
          "TesseractBaseAPI",
          function(obj, level = 3L, ...) {
              .Call("R_TesseractBaseAPI_getConfidences", obj, as(level, "PageIteratorLevel"))
          })

setMethod("getConfidences",
           "character",
          function(obj, level = 3L, ...) {
              ts = tesseract(obj, ...)
              Recognize(ts)
              getConfidences(ts, level)
          })


setGeneric("getBoxes",
           function(obj, level = 3L, keepConfidence = TRUE, ...)
             standardGeneric("getBoxes"))

setMethod("getBoxes",
          "TesseractBaseAPI",
          function(obj, level = 3L, keepConfidence = TRUE, ...) {
              ans = .Call("R_TesseractBaseAPI_getBoundingBoxes", obj, as(level, "PageIteratorLevel"))
              m = do.call(rbind, ans)
              rownames(m) = names(ans)
              colnames(m) = c("confidence", "left", "bottom", "right", "top") #XXXX
              m[, c(2:5, if(keepConfidence) 1)]  # still numeric! Change to integer.  Or leave the confidence in.
          })

setMethod("getBoxes",
           "character",
          function(obj, level = 3L, keepConfidence = TRUE, ...) {
              ts = tesseract(obj, ...)
              Recognize(ts) # Want to avoid doing this twice if possible
              getBoxes(ts, level, keepConfidence)
          })


setMethod("getBoxes",
          "Pix",
          function(obj, level = 3L, keepConfidence = TRUE, ...) {
              api = tesseract(...)
              SetImage(api, obj)
              getBoxes(api, level, keepConfidence)
          })




Clear = 
function(api)
{
  .Call("R_tesseract_Clear",  as(api, "BaseTesseractAPI"))
}

ClearAdaptiveClassifier = 
function(api)
{
  .Call("R_tesseract_ClearAdaptiveClassifier", as(api, "BaseTesseractAPI"))
}



SetRectangle = 
function(api, ..., dims = sapply(list(...), as.integer))
{
  dims = as.integer(dims)
  if(length(dims) < 4)
    stop("incorrect number of dimensions for rectangle")
  
  .Call("R_tesseract_SetRectangle", as(api, "TesseractBaseAPI"), dims)
}

SetSourceResolution =
function(api, ppi)
{
  .Call("R_tesseract_SetSourceResolution", as(api, "TesseractBaseAPI"), as.integer(ppi))
}

ReadConfigFile = 
function(api, files, ok = FALSE)
{
   ff = path.expand(files)
   if(!ok && !all(ok <- file.exists(ff)))
      stop("some files don't exist: ", paste( ff[!ok], collapse = ", "))

   .Call("R_tesseract_ReadConfigFile", as(api, "TesseractBaseAPI"), ff)
}

GetInitLanguages = 
function(api)
{
  .Call("R_tesseract_GetInitLanguagesAsString", as(api, "TesseractBaseAPI"))
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
  
  .Call("R_tesseract_GetVariable", as(api, "TesseractBaseAPI"), as.character(var), rep(0L, length(var)))
}


IsValidWord =
function(api, word)
{
   .Call("R_tesseract_IsValidWord", as(api, "TesseractBaseAPI"), as.character(word))
}


GetInputName =
function(api)
{
  .Call("R_tesseract_GetInputName", as(api, "TesseractBaseAPI"))
}

GetInputImage = GetImage =
function(api, asArray = FALSE)
{
  .Call("R_TessBaseAPI_GetInputImage", as(api, "TesseractBaseAPI"), as.logical(asArray))
}


GetDatapath = GetDataPath =
function(api)
{
  .Call("R_tesseract_GetDatapath", as(api, "TesseractBaseAPI"))
}

GetSourceYResolution =
function(api)
{
  .Call("R_tesseract_GetSourceYResolution", as(api, "TesseractBaseAPI"))
}


PrintVariables =
function(api = tesseract(), asDataFrame = FALSE, file = tempfile())
{
  m = missing(file)
  if(m)
     on.exit(unlink(file))
  
  .Call("R_tesseract_PrintVariables", as(api, "TesseractBaseAPI"), as.character(file))

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
function(api, name, check = TRUE, load = TRUE)
{
  if(is.character(api))
     stop("First argument to SetInputName is the Tesseract object, not the file name")
  
  api = as(api, "TesseractBaseAPI")
    
  if(check)
     checkImageTypeSupported(name)
  if(load)
     SetImage(api, pixRead(name))
  .Call("R_tesseract_SetInputName", api, as.character(name))
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

   


GetThresholdedImage =
function(api)
{
    .Call("R_TessBaseAPI_GetThresholdedImage", as(api, "TesseractBaseAPI"))
}

GetThresholdedImageScaleFactor =
function(api)
{
    .Call("R_TessBaseAPI_GetThresholdedImageScaleFactor", as(api, "TesseractBaseAPI"))
}

pixWrite =
function(pix, file, format)
{
   if(!file.exists(dirname(file)) && file.info(dirname(file))[1, "isdir"])
       stop("no such directory ", dirname(file))
   
   .Call("R_pixWrite", as(pix, "Pix"), as.character(file), as(format, "InputFileFormatValues"))
}


AdaptToWordStr =
function(api, word, segMode = GetPageSegMode(api))
{
  word = as.character(word)
  if(length(word) == 0)
      stop("Must supply a word")
  
  .Call("R_TessBaseAPI_AdaptToWordStr", as(api, "TesseractBaseAPI"), as(segMode, "PageSegMode"), word)
}

AdaptToChar =
function(api, char, baseline, xheight, descender, ascender)
{
  word = as.character(word)
  if(length(word) == 0)
      stop("Must supply a word")
  if(nchar(word) != 1)
      stop("only single characters")

  dims = c(baseline, xheight, descender, ascender)
  
  .Call("R_TessBaseAPI_AdaptToCharacter", as(api, "TesseractBaseAPI"), word, as.numeric(dims))
}


hasRecognized =
function(api)
{
   .Call("R_TessBaseAPI_hasRecognized", as(api, "TesseractBaseAPI"))
}



SetOutputName =
function(api, filename)
{
    if(length(filename) != 1)
        stop("need one file")
    .Call("R_TessBaseAPI_SetOutputName", as(api, "TesseractBaseAPI"), filename)
}

oem =
function(api)
{
   .Call("R_TessBaseAPI_oem", as(api, "TesseractBaseAPI"))
}



ProcessPages =
function(filename, api = tesseract(), timeout = 0L, out = tempfile())
{
    # While the output goes to out, we can pick up the results in the tesseract object if it was passed in
    # otherwise.
  mo = missing(out)
  if(.Call("R_TessBaseAPI_ProcessPages", as(api, "TesseractBaseAPI"), filename, as.integer(timeout), as.character(out))) {
     if(mo)
       return(readLines(out))
  }
  api
}



ClearPersistentCache =
function(...)
{
   .Call("R_tesseract_ClearPersistentCache")
}


GetTextDirection =
function(api)
{
    .Call("R_TessBaseAPI_GetTextDirection", as(api, "TesseractBaseAPI"))
}

DetectOS =
function(api)
{
    .Call("R_TessBaseAPI_DetectOS", as(api, "TesseractBaseAPI"))
}
