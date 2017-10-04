\name{IFF_PNG}
\alias{IFF_UNKNOWN}
\alias{IFF_BMP}
\alias{IFF_JFIF_JPEG}
\alias{IFF_PNG}
\alias{IFF_TIFF}
\alias{IFF_TIFF_PACKBITS}
\alias{IFF_TIFF_RLE}
\alias{IFF_TIFF_G3}
\alias{IFF_TIFF_G4}
\alias{IFF_TIFF_LZW}
\alias{IFF_TIFF_ZIP}
\alias{IFF_PNM}
\alias{IFF_PS}
\alias{IFF_GIF}
\alias{IFF_JP2}
\alias{IFF_WEBP}
\alias{IFF_LPDF}
\alias{IFF_DEFAULT}
\alias{IFF_SPIX}
\docType{data}
\title{File Format Symbolic Constants}
\description{
These variables are symbolic constants used to identify different image
file formats. We use them in \code{\link{pixWrite}} to indicate the
desired file format for the image being written.
These are better than strings, e.g. "PNG", or simple numbers, e.g. 3.
However, one can use either of these forms also. However, \code{IFF_PNG}
is preferred to "PNG" and both are  much preferred to 3.
}
\usage{data("IFF_PNG")}
\format{
  The format is:
Formal class 'InputFileFormat' [package "Rtesseract"] with 2 slots
  ..@ .Data: int 3
  ..@ names: chr "IFF_PNG"
}
\source{
Leptonica imageio.h heade file.
}
\references{
\url{http://www.leptonica.org}
}
\seealso{
  \code{\link{pixWrite}}
}
\examples{
\dontrun{
  f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
  p = pixRead(f)
  pixWrite(p, "foo.webp", IFF_WEBP)
  pixWrite(p, "foo.tiff", IFF_TIFF_LZW)
  pixWrite(p, "foo.webp", "WEBP")
  pixWrite(p, "foo.tiff", "TIFF_LZW")

  pixWrite(p, "foo.webp")
}
}
\keyword{datasets}
