setClass("Document", contains = "VIRTUAL")

# Could have OCRDocument be a list of OCRPage objects.
setClass("OCRDocument", contains = c("character", "Document"))
setClass("OCRDocumentSubset", contains = c("OCRDocument"))
setClass("OCRPage", contains = "character")
# example
# doc = new("OCRDocument", list.files("ScannedEgs", pattern = "Shope-1970_.*.png", full = TRUE))
# OCRDocument("ScannedEgs/Mebatsion-1992.pdf")


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

  new("OCRDocument", pages)
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



if(FALSE) {

    # Get signature correct.
    
if(!isGeneric("getTextBBox"))
 setGeneric("getTextBBox",
            function(obj, ...)
             standardGeneric("getTextBBox"))


setMethod("getTextBBox", "OCRPage",
         function(obj, ...) {
  		    # Should be getTextBBox()?
		   GetBoxes(as.character(obj), ...)
		 })
}


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
