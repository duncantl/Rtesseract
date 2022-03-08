setGeneric("GetFontInfo",
           function(obj, level = 3L, ...)
             standardGeneric("GetFontInfo"))

setMethod("GetFontInfo",
          "TesseractBaseAPI",
          function(obj, level = 3L, ...) {
              if(!hasRecognized(obj))
                  Recognize(obj)

              els = .Call("R_TessBaseAPI_GetFontInfo", obj, as(level, "PageIteratorLevel"))

              ans = do.call(rbind, els)
              ans = as.data.frame(ans)
              ans[1:6] = lapply(ans[1:6], as.logical)
              names(ans) = c("bold", "italic", "underlined", "monospace", "serif", "smallcaps", "pointsize", "fontId")
              ans$font = names(els)
              ans
          })

setMethod("GetFontInfo",
           "character",
          function(obj, level = 3L, ...) {
              ts = tesseract(obj, ...)
              Recognize(ts) # Want to avoid doing this twice if possible
              GetFontInfo(ts, level, ...)
          })

setMethod("GetFontInfo",
          "Pix",
          function(obj, level = 3L,  ...) {
              api = tesseract(...)
              SetImage(api, obj)
              GetFontInfo(api, level)
          })
