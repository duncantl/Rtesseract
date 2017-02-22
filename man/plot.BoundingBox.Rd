\name{plotSubImage}
\alias{plotSubImage}
\title{Plot function for a Bounding Box}
\description{
  The \code{plotSubImage} function
  takes a bounding box 
  and an image and displays the subset of the image
  specified by the bounding box.
  The bounding box is a vector of length 4
  giving the pixel indices x1, y1, x2, y2
  of the corners of the rectangular bounding box.
  We use this to draw a separate plot for a term
  recognized by the OCR mechanism. This is useful
  for looking at misclassified terms.

  This  is unrelated to the tesseract API and is used
  for examining the region of the image in R.
}
\usage{
plotSubImage(box, img, ...)
}
\arguments{
  \item{box}{ a vector of length 4 giving the x1, y1, and x2, y2
    coordinates of the sub-region.}
  \item{img}{the image object read using the appropriate function in
  the appropriate package for the image type. See \code{png},
    \code{rjpeg}, or \code{rtiff}.}
  \item{\dots}{additional arguments passed to the inherited \code{plot} methods.}
}
\value{
  The purpose of this function is the side-effect of plotting the sub-image
  The result is \code{NULL}. 
}
\author{
Duncan Temple Lang
}

\seealso{
 \code{\link{GetBoxes}}
}
\examples{
f = system.file("images", "OCRSample2.png", package = "Rtesseract")
pix = pixRead(f)
api = tesseract(pix)
Recognize(api)
bbox = lapply(api, BoundingBox, "textline")

if(FALSE && require("png")) {
  img = png::readPNG(f)
  par(mfrow = c(3, 3))
  invisible(lapply(bbox, plotSubImage, img))
  invisible(lapply(bbox, plotSubImage, img, axes = FALSE, xlab = "", ylab = ""))
}
}
\keyword{graphics}
\keyword{IO}
