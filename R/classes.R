setClass("TesseractRef", representation(ref = "externalptr"))
setClass("TessBaseAPI", contains = "TesseractRef")
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

#setValidity("PageIteratorLevel"


#setGeneric("pixRead", function(x, ...) standardGeneric("pixRead"))

#setGeneric("SetImage", function(x, ...) standardGeneric("SetImage"))

#setGeneric("Recognize", function(x, ...) standardGeneric("Recognize"))



