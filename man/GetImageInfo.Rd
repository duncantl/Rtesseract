\name{GetImageInfo}
\alias{GetImageInfo}
\alias{GetImageInfo,TesseractBaseAPI-method}
\alias{GetImageInfo,Pix-method}
\alias{GetImageDims}
\alias{GetImageDims,Pix-method}
\alias{GetImageDims,TesseractBaseAPI-method}

\title{Get Information about the Current Tesseract Image}
\description{
These methods provide information about the current image being
processed by a tesseract OCR instance.
We can query the dimensions of the image (rows, columns and depth)
and also information about the samples per pixel,
x and y resolution (not pixels), the format and the color depth.
}
\usage{
GetImageInfo(obj, ...)
GetImageDims(obj, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{obj}{an object of class 
        \code{\link{TesseractBaseAPI-class}} objected created via a call
	to \code{\link{tesseract}}.
}
  \item{\dots}{additional arguments for future methods}
}
\value{
  \code{\link{GetImageInfo}} returns a numeric vector with 5 elements.
  \item{samplesPerPixel}{}
  \item{xres}{}
  \item{yres}{}
  \item{informat}{}
  \item{colorDepth}{}

  \code{\link{GetImageDims}} returns a numeric vector with 3 elements.
  \item{height}{the number of rows}
  \item{width}{the number of columns}
  \item{depth}{the number of "planes" in the image}  
  
  In either case, if there is no image, the method returns \code{NULL}.
}
\note{
It is possible to pass a 
\code{\link{Pix-class}} object as the value of \code{obj}
in these functions.
One can obtain the \code{\link{Pix-class}} object via
a call to the unexported  \code{\link{SetImage}} or  \code{GetImage},
or alternatively, via \code{pixRead}.
If one obtains the \code{\link{Pix-class}} instance from
a tesseract instance, it is only valid
as long as the corresponding tesseract object is valid and not garbage collected.
In other words, if you obtain the image and then remove
the references to the tesseract object, you should  not use the
image object.
}
\references{
Tesseract API Documentation.
}
\author{
Duncan Temple Lang
}

\seealso{
\code{\link{tesseract}}  
\code{\link{SetImage}}
%\code{\link{GetImage}}
}
\examples{
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
ts = tesseract(f)
GetImageDims(ts)
GetImageInfo(ts)

\dontrun{
# Don't get the Pix object this way.
pix = GetInputImage(ts, FALSE)
GetImageDims(pix)
GetImageInfo(pix)
rm(pix)
}
}
\keyword{IO}
