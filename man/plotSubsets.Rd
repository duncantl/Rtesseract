\name{plotSubsets}
\alias{plotSubsets}
\title{Plot a collection of individual a Bounding Boxes}
\description{
  This is a convenience wrapper to apply the \code{plotSubImage}
  function over a collection of bounding boxes. It takes
  a collection of bounding boxes from \code{GetBoxes} 
  and an image and displays the subset of the image
  specified by the bounding box arranged in a panel grid,
  with the recognized output and associated confidences printed in the
  title. This is useful for looking at misclassified terms.

  This  is unrelated to the tesseract API and is used
  for examining the region of the image in R.
}
\usage{
plotSubsets(bbox, img, nrow = 4, ncol = 4, ...)
}
\arguments{
  \item{box}{ bounding boxes as created by \code{GetBoxes}, with columns
	left, bottom, right, top, and confidences and rownames of the
	recognized characters.}
  \item{img}{the image object read using the appropriate function in
  the appropriate package for the image type. See \code{png},
  \code{rjpeg}, or \code{tiff}.}
  \item{nrow}{the number of rows in the panel.}
  \item{ncol}{the number of columns in the panel.} 
  \item{\dots}{additional arguments passed to the inherited \code{plotSubImage} methods.}
}
\value{
  The purpose of this function is the side-effect of plotting the sub-image
  The result is \code{NULL}. 
}
\author{
Matthew Espe
}

\seealso{
  \code{\link{GetBoxes}}
  \code{\link{plotSubImages}}
}
\examples{
f = system.file("images", "OCRSample2.png", package = "Rtesseract")
pix = pixRead(f)
api = tesseract(pix)
bbox = GetBoxes(api, "textline")
#Recognize(api)
#bbox = lapply(api, BoundingBox, "textline")

if(FALSE && require("png")) {
  img = png::readPNG(f)
  plotSubsets(bbox, img, nrow = 10, ncol = 1)
}
}
\keyword{graphics}
\keyword{IO}
