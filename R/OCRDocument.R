# Could have OCRDocument be a list of OCRPage objects.
# or a character vector of file names.
#setClass("OCRDocument", contains = c("character", "Document"))
setClass("OCRDocument", contains = c("list", "Document"))
#XXX Turned this off for ProcessedOCRDocument.
setClass("OCRDocumentFiles", contains = "OCRDocument")
setValidity("OCRDocumentFiles", function(object) all(sapply(object, is, "DocumentPage")))

setClass("OCRDocumentSubset", contains = c("OCRDocument"))

setClass("OCRPage", contains = c("character", "DocumentPage"))

#XXX
setClass("ProcessedOCRDocument", contains = "OCRDocument")
# Validity

setOldClass(c("WordOCRResults", "OCRResults", "TextBoundingBox", "BoundingBox", "data.frame"))
# Note the DocumentPage addition.
# Doesn't work - setIs("OCRResults", "DocumentPage")

# example
# doc = new("OCRDocument", list.files("ScannedEgs", pattern = "Shope-1970_.*.png", full = TRUE))
# OCRDocument("ScannedEgs/Mebatsion-1992.pdf")


if(FALSE) # not needed if OCRDocument is a list of OCRPage objects.
setMethod("[[", "OCRDocument",
           function(x,i, j, ..., exact = TRUE) {
		      new("OCRPage", x[i])
                  })

setMethod("[", "OCRDocument",
           function(x,i, j, ..., drop = TRUE) {
		      new("OCRDocumentSubset", callNextMethod())
		   })


OCRDocument =
function(filename, pages = getOCRPageFiles(filename))
{
  if(!file.exists(filename))
    stop("No such file ", filename)
	
  if(length(pages) == 0)
      pages = pdf2png(filename)

  new("OCRDocument", structure(lapply(pages, function(x) new("OCRPage", x)), names = pages))
}


ProcessedOCRDocument =
function(filename, pages = getOCRPageFiles(filename), bboxes = lapply(pages, GetBoxes, ...),  ...)
{
   new("ProcessOCRDocument", bboxes)
}

if(FALSE) {
    # See getConvertedFilenames in pdf2png.R
 getOCRPageFiles =
 function(filename)
 {
    base = rmExt(filename)
    list.files(dirname(filename), pattern = paste0(base, "_p[0-9]+"), full.names = TRUE)
 }
}



getShapesBBox.OCRPage =
function(obj, asDataFrame = TRUE, color = TRUE, diffs = FALSE, dropCropMarks = TRUE, ...)    
   getLines(pixRead(obj), asDataFrame = asDataFrame)

getTextBBox.OCRPage =
function(obj, asDataFrame = TRUE, color = TRUE, diffs = FALSE, dropCropMarks = TRUE, ...)
    GetBoxes(obj, asMatrix = !asDataFrame, ...)


# Isn't this in Dociface now but for getTextBBox().
setMethod("GetBoxes", "OCRDocument",
          function (obj, level = 3L, keepConfidence = TRUE, asMatrix = FALSE, collapse = TRUE, ...)  {

              ans = lapply(obj, GetBoxes, level, keepConfidence, asMatrix)
              if(collapse) {
                  n = sapply(ans, nrow)
                  k = class(ans[[1]])
                  ans = do.call(rbind, ans)
                  ans = cbind(ans, page = rep(seq(along = obj), n))
                  class(ans) = c("MultiPage", k) 
              }
              
              ans
          })

# Need to define the generics for these somewhere.
# Do we need a separate "VIRTUAL" package from which these are inherited.
#

setMethod("getNumPages", "OCRDocument",
          function(doc)
          length(doc))

setMethod("getPages", "OCRDocument",
          function(doc)
            unclass(doc))
# No need for lapply(doc, function(x) new("OCRPage", x)))



setMethod("dim", "OCRPage",
          function(x)
             dim(pixRead(x)))

# XXX reconcile this with the idea of returning a matrix with a row for each page of the document.
if(FALSE)
setMethod("dim", "OCRDocument",
          function(x) {
              tmp = sapply(x, dim) #  since now OCRDocument is a list of OCRPage, don't need function(x) dim(pixRead(x)))
              c(min(tmp[1,]), max(tmp[2,]))
          })


setAs("OCRPage", "TextBoundingBox",
         function(from) {
              GetBoxes(from)
          })



# left and right are in Dociface.

setMethod("right", "OCRResults", function(x, ...) x$right)
setMethod("bottom", "OCRResults", function(x, ...) x$bottom)
setMethod("width", "OCRResults", function(x, ...) x$right - x$left)
setMethod("height", "OCRResults", function(x, ...) x$top  - x$bottom)
