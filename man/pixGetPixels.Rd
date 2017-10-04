\name{pixGetPixels}
\alias{pixGetPixels}
\alias{pixGetRGBPixels}
\alias{pixSetPixels}
\alias{pixSetRGBPixels}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Get and Set the Pixels in a Pix Object}
\description{
 These functions allow us to query and set all of the pixels in a
 \code{\link{Pix-class}}  image.
 The image may be either a gray-scale (including binary) or an RGB image.
}
\usage{
pixGetPixels(pix, dims = pixGetDims(pix))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{pix}{a \code{\link{Pix-class}} object}
  \item{dims}{the dimensions of the \code{\link{Pix-class}} object}
}

\value{
  \code{pixGetPixels} returns a matrix.

  \code{pixGetRGBPixels} returns a 3-dimensional  array with
  rows, columns and depth corresponding to the height of the image,
  the width of the image, and the three color channels, Red, Green and Blue.
}
\references{
  \url{http://tpgit.github.io/UnOfficialLeptDocs/}
}

\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{pixRead}}
  \code{\link{GetInputImage}}
  \code{\link{pixAnd}}  
}
\examples{
  f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
  p = pixRead(f)
  m = pixGetPixels(p)
  m = p[,]

  p2 = pixConvertTo8(p)
  m2 = p[,]

  a = pixGetRGBPixels(p)
  dim(a)
}
\keyword{manip}
\concept{image processing}