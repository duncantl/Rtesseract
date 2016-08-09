\name{getImageInfo}
\alias{getImageInfo}
\alias{getImageInfo,TesseractBaseAPI-method}
\alias{getImageInfo,Pix-method}
\alias{getImageDims}
\alias{getImageDims,Pix-method}
\alias{getImageDims,TesseractBaseAPI-method}

\title{Get Information about the Current Tesseract Image}
\description{
These methods provide information about the current image being
processed by a tesseract OCR instance.
We can query the dimensions of the image (rows, columns and depth)
and also information about the samples per pixel,
x and y resolution (not pixels), the format and the color depth.
}
\usage{
getImageInfo(obj, ...)
getImageDims(obj, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{obj}{an object of class \code{\link{Pix-class}} via a call to
    \code{\link{SetImage}} or  \code{\link{GetImage}},
    or alternatively, a
        \code{\link{TesseractBaseAPI-class}} objected created via a call
	to \code{\link{tesseract}}.
}
  \item{\dots}{additional arguments for future methods}
}
\value{
  \code{\link{getImageInfo}} returns a numeric vector with 5 elements.
  \item{samplesPerPixel}{}
  \item{xres}{}
  \item{yres}{}
  \item{informat}{}
  \item{colorDepth}{}

  \code{\link{getImageDims}} returns a numeric vector with 3 elements.
  \item{height}{the number of rows}
  \item{width}{the number of columns}
  \item{depth}{the number of "planes" in the image}  
  
  In either case, if there is no image, the method returns \code{NULL}.
}
\references{
Tesseract API Documentation.
}
\author{
Duncan Temple Lang
}

\seealso{
\code{\link{tesseract}}  
 \code{\link{SetImage}},  \code{\link{GetImage}}
}
\examples{
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
ts = tesseract(f)
getImageDims(ts)
getImageInfo(ts)

pix = GetInputImage(ts, FALSE)
getImageDims(pix)
getImageInfo(pix)
}
\keyword{IO}
