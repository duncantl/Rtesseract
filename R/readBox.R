if(FALSE) {
    library(Rtesseract)
    d = readBoxFile(system.file("trainingSample", "eng.tables.exp0.box", package = "Rtesseract"), dim(img))
    plot(d)
    plot(d[ d[,2] > 1500, ], cex = 1.2)
}

setOldClass(c("TesseractBoxdata", "data.frame"))

readBoxFile =
    # Read a file  created as part of the training.
    # e.g., tesseract eng.tables.ex0.png eng.tables.ex0 batch.nochop makebox
    # There is an example in inst/trainingSample/eng.tables.ex0.box
    #
    # This returns a data frame with the columns reordered to be like a bounding box
    # This is not like a bounding box exactly as that is a matrix and the rownames are the
    # values for the corresponding box.  But they are not necessarily unique and so
    # cannot be rownames of a data frame.
    #
    # This adds the class TesseractBoxdata to the data frame so that we can dispatch methods on this.
    # e.g. getTextInfo()
    #
function(file, imgDim = integer(), ...)
{
   d = read.table(file, stringsAsFactors = FALSE, quote = '', comment.char = '', ...)
   d = d[, c(2, 3, 4, 5, 1)]
   colnames(d) = c("left", "bottom", "right", "top", "text")
   class(d) = c("TesseractBoxdata", class(d))

#  if(length(imgDim) == 0)
#     r =  max(unlist(d[, c(2, 4)]))
#  else
#     r = imgDim[1]
#
#  d[,2] = r- d[,2]
#  d[,4] = r- d[,4]    
   
   if(is.character(file))
      attr(d, "file") = file
   
   d
}


if(FALSE) {
getTextInfo =
function(x, ...)
  UseMethod("getTextInfo")

getTextInfo.default =
function(x, ...)
    NULL

getTextInfo.TesseractBoxdata =
function(x, ymax = NA, ...)
{
  ans = x[, c("left", "bottom", "text")]
# if(is.na(ymax))
#     ymax = max(ans[,2])
# ans[,2] =  ymax - ans[,2]
  ans
}
}


plot.TesseractBoxdata =
function(x, str.cex = .9, ...)
{
    plot(0, type = "n", xlim = range(x[, c(1, 3)]), ylim = range(x[, c(2, 4)]), xlab = "", ylab = "")
    rect(x[,1], x[,2], x[,3], x[, 4])
    opar = par(no.readonly = TRUE)
    on.exit(par(opar))
    par(pty = "s")
    text(x[,1], x[,2], x[, "text"], adj = c(-0.2, -.2), cex = str.cex)
}

#setMethod("plot", "TesseractBoxdata",
#           function(x, ...)
#             plot.TesseractBoxdata(x, ...))

setMethod("plot", "TesseractBoxdata", plot.TesseractBoxdata)

