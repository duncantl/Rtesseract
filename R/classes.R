setClass("TesseractRef", representation(ref = "externalptr"))
setClass("TesseractBaseAPI", contains = "TesseractRef")
setClass("ResultIterator", contains = "TesseractRef")

setClass("Pix", contains = "TesseractRef")


PageIteratorLevel = c(block = 0L, para = 1L, textline = 2L, word = 3L, symbol = 4L)

setClass("PageIteratorLevel", contains = "integer")

setAs("numeric", "PageIteratorLevel",
       function(from) {
           i = match(from, PageIteratorLevel)
           if(is.na(i))
               stop("Not a valid PageIteratorLevel value")

           new("PageIteratorLevel", PageIteratorLevel[i])
       })

setAs("character", "PageIteratorLevel",
       function(from) {
           i = match(from, names(PageIteratorLevel))
           if(is.na(i))
               stop("Not a valid PageIteratorLevel value")

           new("PageIteratorLevel", PageIteratorLevel[i])
       })


#setValidity("PageIteratorLevel"


#setGeneric("pixRead", function(x, ...) standardGeneric("pixRead"))

#setGeneric("SetImage", function(x, ...) standardGeneric("SetImage"))

#setGeneric("Recognize", function(x, ...) standardGeneric("Recognize"))





setClass("TessResultRenderer", contains = "TesseractRef")
setClass("TessPDFRenderer", contains = "TessResultRenderer")
setClass("TessTsvRenderer", contains = "TessResultRenderer")
setClass("TessHOcrRenderer", contains = "TessResultRenderer")
setClass("TessOsdRenderer", contains = "TessResultRenderer")
setClass("TessUnlvRenderer", contains = "TessResultRenderer")
setClass("TessTextRenderer", contains = "TessResultRenderer")
setClass("TessBoxTextRenderer", contains = "TessResultRenderer")



setMethod("$", "TesseractBaseAPI",
          function(x, name)
             GetVariables(x)[[name]]
          )

setMethod("$<-", "TesseractBaseAPI",
          function(x, name, value) {
              SetVariables(x, opts = structure(list(value), names = name))
              x
          })

setMethod("[[", c("TesseractBaseAPI", "character"),
          function(x, i, ...) {
              GetVariables(x, i)[[1]]
          })

setMethod("[[<-", c("TesseractBaseAPI", "character"),
          function(x, i, ..., value) {
              SetVariables(x, opts = structure(list(value), names = i))
              x
          })

setMethod("[", c("TesseractBaseAPI", "character"),
          function(x, i, j, ...) {
              GetVariables(x)[i]
          })

setMethod("[<-", c("TesseractBaseAPI", "character"),
          function(x, i, j, ..., value) {
              if(length(value) != length(i))
                  value = rep(value, length = length(i))
              opts = structure(value, names = i)
              SetVariables(x, opts = opts)
              x
          })

setMethod("names", "TesseractBaseAPI",
          function(x)
             names(GetVariables(x)))
