tesseract =
function(image = character(), pageSegMode = integer(), lang = "eng", datapath = NA,
         configs = character(), vars = character(), engineMode = OEM_DEFAULT, debugOnly = FALSE,
         ..., opts = list(...), init = TRUE)
{
  api = .Call("R_TessBaseAPI_new")

  if(!init && ((length(image) && (is.character(image) && file.exists(image))) || length(opts))) {
     warning("forcing a call to Init() since setting the image and/or variables.")
     init = TRUE
  }

  if(!is.na(datapath)) 
      datapath = normalizePath(datapath)

  if(init)
     Init(api, lang, datapath = datapath, configs = configs, vars = vars, engineMode = engineMode, debugOnly = debugOnly)

  if(length(opts) > 0)
     SetVariables(api, opts = opts)  
    
  if(length(pageSegMode))  # Make certain this happens after Init() as the C++ Init() resets PageSegMode
      SetPageSegMode(api, pageSegMode)
    
  if(length(image))
     SetImage(api, image)
  
  api
}

Init = 
function(api, lang = "eng", configs = character(), vars = character(), datapath = NA, engineMode = OEM_DEFAULT, debugOnly = FALSE, force2 = TRUE)
{
  if(!is.na(datapath) && (!file.exists(datapath) || !file.info(datapath)[1, "isdir"])) 
      stop("No such directory ", datapath)

    #  datapath may not be specified,  so if we want to do the test, we need to
    #    datapath Sys.getenv("TESSDATA_PREFIX")
    # if(engineMode == 2 && !file.exists( sprintf("%s/%s.traineddata", datapath, lang) ))
    #     stop("This will probably segfault")
  
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
  .vars = sapply(opts, function(x) paste(as(x, "character"), collapse = ""))
  .vars[ .vars == "FALSE" ] = "F"
  .vars[ .vars == "TRUE" ] = "T"  
    
  .Call("R_TessBaseAPI_SetVariables", as(api, "TesseractBaseAPI"),  .vars)
}

pixRead = 
function(filename, addFinalizer = TRUE, multi = FALSE, ...)
{
   filename = path.expand(filename)
   if(!file.exists(filename))
      stop("no such file ",  filename)

   if(multi && grepl("TIFF", names(readImageInfo(filename)$format))) {
       ans = readMultipageTiff(filename)
       if(length(ans) == 1)
           ans[[1]]
       else
           ans
   } else
      .Call("R_pixRead", filename, as.logical(addFinalizer))
}

SetImage = 
function(api, pix, filename = NA)
{
  if(is.character(pix)) {
     if(!file.exists(pix))
        stop("No such file ", pix)
     if(is.na(filename))
        filename = pix
     pix = pixRead(pix, FALSE) # Don't add a finalizer
 }
  
  if(!is.na(filename))
     SetInputName(api, filename, load = FALSE)

  .Call("R_TessBaseAPI_SetImage", as(api, "TesseractBaseAPI"), pix)
  pix
}

Recognize =
function(api)
{
   setAtExitFlag(TRUE)
   on.exit(setAtExitFlag(FALSE))    
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
               lapply(GetIterator(X), FUN, level, ...)
           })


# TesseractBasePix to a Pix.
setAs("TesseractBaseAPI", "Pix", function(from) GetImage(from))


if(FALSE) # Don't expose this.
setAs("TesseractBaseAPI", "ResultIterator",
        function(from) {
              # Do we need to ensure Recognize() has been called ?
            GetIterator(from)
        })
      
    

if(FALSE){
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
} # end of if(FALSE)

if(FALSE) {
BoundingBox =
    # Retire this - GetBoxes()
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
} #end of if(FALSE)


GetText =
function(obj, level = 3L, ...)
{
  names(GetConfidences(obj, level, ...))
}



setGeneric("GetAlternatives",
           function(obj,  ...)
             standardGeneric("GetAlternatives"))

setMethod("GetAlternatives",
          "TesseractBaseAPI",
          function(obj, ...) {
            if(!hasRecognized(obj))
              Recognize(obj)

           GetAlternatives(GetIterator(obj))
  #          .Call("R_getAllAlternatives", obj, as(level, "PageIteratorLevel"))
          })


setMethod("GetAlternatives",
          "ResultIterator",
          function(obj, ...) {
             lapply(obj, "getAlts", as(4L, "PageIteratorLevel"))
#            .Call("R_Current_getAlternatives", obj, as(level, "PageIteratorLevel"))
          })


setMethod("GetAlternatives",
           "character",
          function(obj, ...) {
              ts = tesseract(obj, ...)
              Recognize(ts)
              GetAlternatives(ts)
          })

setMethod("GetAlternatives",
           "Pix",
          function(obj, ...) {
              ts = tesseract(...)
              SetImage(ts, obj)              
              Recognize(ts)
              GetAlternatives(ts)
          })



setGeneric("GetConfidences",
           function(obj, level = 3L, ...)
             standardGeneric("GetConfidences"))

setMethod("GetConfidences",
          "Pix",
          function(obj, level = 3L, ...) {
              api = tesseract(...)
              SetImage(api, obj)
              GetConfidences(api, level)
          })

setMethod("GetConfidences",
          "TesseractBaseAPI",
          function(obj, level = 3L, ...) {
              if(!hasRecognized(obj))
                 Recognize(obj)
              .Call("R_TesseractBaseAPI_getConfidences", obj, as(level, "PageIteratorLevel"))
          })

setMethod("GetConfidences",
           "character",
          function(obj, level = 3L, ...) {
              ts = tesseract(obj, ...)
              Recognize(ts)
              GetConfidences(ts, level)
          })


setGeneric("GetBoxes",
           function(obj, level = 3L, keepConfidence = TRUE, asMatrix = FALSE, ...)
             standardGeneric("GetBoxes"))

setMethod("GetBoxes",
          "TesseractBaseAPI",
          function(obj, level = 3L, keepConfidence = TRUE, asMatrix = FALSE, ...) {
              if(!hasRecognized(obj))
                 Recognize(obj)
              
              ans = .Call("R_TesseractBaseAPI_getBoundingBoxes", obj, as(level, "PageIteratorLevel"))
              if(length(ans) == 0) {
                 m = data.frame(confidence = numeric(), left = integer(), bottom = integer(), right = integer(), top = integer())
              } else
                 m = do.call(rbind, ans)
              
              colnames(m) = c("confidence", "left", "bottom", "right", "top") #XXXX
              if(asMatrix) {
                  rownames(m) = names(ans)
                  cols = 2:5
              } else {
                  m = as.data.frame(m)
#                  class(m) = c("OCRPositionResults", class(m))
                  m$text = if(length(ans)) names(ans) else character()
                  rownames(m) = NULL
                  cols = 2:6
              }

              ans = m[, c(cols, if(keepConfidence) 1)]  # still numeric! Change to integer.  Or leave the confidence in.
              class(ans) = c("OCRResults", class(ans))
              attr(ans, "imageDims") = GetImageDims(obj) # was dim(GetImage(obj)) which causes seg faults due to image being released twice or corrupted at least. Once by ~TessBaseAPI and once elsewhere.

              if(keepConfidence)
                 class(ans) = c("OCRResultsConfidences", class(ans))

              k = sprintf("%sOCRResults", capitalize(gsub("RIL_", "", names(as(level, "PageIteratorLevel")))))
              class(ans) = c(k, class(ans))
              
              ans
          })

capitalize =
function(x)
{
  paste0(toupper(substring(x, 1, 1)), tolower(substring(x, 2)))
}

setMethod("GetBoxes",
           "character",
          function(obj, level = 3L, keepConfidence = TRUE, asMatrix = FALSE, ...) {
              ts = tesseract(obj, ...)
              Recognize(ts) # Want to avoid doing this twice if possible
              GetBoxes(ts, level, keepConfidence, asMatrix)
          })


setMethod("GetBoxes",
          "Pix",
          function(obj, level = 3L, keepConfidence = TRUE, asMatrix = FALSE, ...) {
              api = tesseract(...)
              SetImage(api, obj)
              GetBoxes(api, level, keepConfidence, asMatrix)
          })


setMethod("dim", "TesseractBaseAPI",
          function(x)
             GetImageDims(x)[1:2])


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
    #
    # Specify as left, top, width, height
    #
function(api, ..., dims = sapply(list(...), as.integer))
{
  dims = as.integer(dims)
  if(length(dims) < 4)
      stop("incorrect number of dimensions for rectangle")
  
  imgDim = GetImageDims(api)
  if(any(dims < 0) || (dims[1] + dims[3]) > imgDim["width"] || (dims[2] + dims[4]) > imgDim["height"])
      stop("Specified dims exceed image boundaries - please ensure dims were specified as left, top, width, and height.")

  
  .Call("R_tesseract_SetRectangle", as(api, "TesseractBaseAPI"), dims)
}

SetSourceResolution =
function(api, ppi)
{
  .Call("R_tesseract_SetSourceResolution", as(api, "TesseractBaseAPI"), as.integer(ppi))
}

ReadConfigFile = 
function(api, files, debug = FALSE, ok = FALSE)
{
   ff = path.expand(files)
     # We can use GetDatapath() and add /configs/ to that 
   if(!ok && !all(ok <- file.exists(ff)))
      stop("some files don't exist: ", paste( ff[!ok], collapse = ", "))
   
   setAtExitFlag(TRUE)
   on.exit(setAtExitFlag(FALSE))
   
   .Call("R_tesseract_ReadConfigFile", as(api, "TesseractBaseAPI"), ff, as.logical(debug))
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


setGeneric("GetImageDims", function(obj, ...) standardGeneric("GetImageDims"))

setMethod("GetImageDims", "TesseractBaseAPI",
          function(obj, ...) {
              ans = .Call("R_TessBaseAPI_GetImageDimensions", obj)
              if(length(ans))
                 names(ans) = c("height", "width", "depth")
              ans
          })

setMethod("GetImageDims", "Pix",
          function(obj, ...) {
              ans = .Call("R_Pix_GetDimensions", obj)
              names(ans) = c("height", "width", "depth")
              ans
          })

setMethod("GetImageDims", "OCRResults", function(obj, ...) attr(obj, "imageDims"))

setGeneric("GetImageInfo", function(obj, ...) standardGeneric("GetImageInfo"))

setMethod("GetImageInfo", "TesseractBaseAPI",
          function(obj, ...) {
              ans = .Call("R_TessBaseAPI_GetImageInfo", obj)
              names(ans) = c("samplesPerPixel", "xres", "yres", "informat", "colorDepth")  # from .../include/leptonica/pix.h
              ans
          })
setMethod("GetImageInfo", "Pix",
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
function(pix, file, format = guessImageFormatByExt(file))
{
   if(!file.exists(dirname(file)) && file.info(dirname(file))[1, "isdir"])
       stop("no such directory ", dirname(file))

   if(is.na(format) || format == "")
       stop("Don't recognize the image file format") 
   
   .Call("R_pixWrite", as(pix, "Pix"), as.character(file), as(format, "InputFileFormat"))
}

guessImageFormatByExt =
# Rtesseract:::guessImageFormat("foo.jpeg")
#<NA> 
#  NA 
#[22:21] 3> Rtesseract:::guessImageFormat("foo.jpg")
#<NA> 
#  NA 
#Rtesseract:::guessImageFormat("foo.tiff")
#IFF_TIFF 
#       4 
#Rtesseract:::guessImageFormat("foo.gif")
#IFF_GIF 
#     13 
# Rtesseract:::guessImageFormat("foo.jp2")
#IFF_JP2 
    #     14
# Rtesseract:::guessImageFormat("foo.png")
#IFF_PNG 
#     3     
#[22:55] 7> Rtesseract:::guessImageFormat("foo.webp")    
function(filename, values = InputFileFormatValues)
{
    ext = gsub(".*\\.", "", filename)
       #XXX  May want to determine most appropriate/supported version for tiff.
    ext = switch(ext, pdf = "lpdf", jpg=, jpeg = "jp2", tiff = "tiff_lzw", ext)
    i = pmatch(tolower(ext), gsub("^iff_", "", tolower(names(values))))
    values[i]
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

`oem<-` = 
function(x, ..., value)
{
    api = as(x, "TesseractBaseAPI")
    Init(api, engineMode = as(value, "OcrEngineMode"))
    api
}


if(FALSE) 
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



getAvailableLanguages =
function(api = tesseract())
{    
    .Call("R_TessBaseAPI_GetAvailableLanguagesAsVector", api)
}
