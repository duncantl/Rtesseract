setClass("TesseractRef", representation(ref = "externalptr"))
setClass("TessBaseAPI", contains = "TesseractRef")
setClass("ResultIterator", contains = "TesseractRef")

setClass("Pix", contains = "TesseractRef")


#setGeneric("pixRead", function(x, ...) standardGeneric("pixRead"))

#setGeneric("SetImage", function(x, ...) standardGeneric("SetImage"))

#setGeneric("Recognize", function(x, ...) standardGeneric("Recognize"))



