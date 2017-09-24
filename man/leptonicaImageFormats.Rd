\name{leptonicaImageFormats}
\alias{leptonicaImageFormats}
\title{Query the Supported Image Formats}
\description{
  This function allows us to query which image formats the OCR
  system can recognize. These are determined at configuration
  time when the package is being installed and the code compiled.
}
\usage{
leptonicaImageFormats()
}
\value{
 A logical vector with names corresponding to the image formats.
}
\references{
Leptonica \url{http://leptonica.com/}  
Tesseract \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}
\seealso{
  \code{\link{pixRead}}
  \code{\link{leptonicaVersion}}
}
\examples{
leptonicaImageFormats()
}
\keyword{IO}
\keyword{programming}
