\name{pixRead}
\alias{pixRead}
\alias{Pix-class}
\title{Read an Image for use with Tesseract}
\description{
  This function reads an image, determining what format it is
  and creates a C++ object that can be passed to Tesseract
  for optical character recognition.
}
\usage{
pixRead(filename, ...)
}
\arguments{
  \item{filename}{the name of the file, fully or relatively qualified as
  necessary.}
  \item{\dots}{additional arguments, currently ignored.}
}
\value{
  An object of class \code{Pix-class}.
  It is essential that this is assigned to an R variable so that
  it is not garbage collected until the \code{\link{Recognize}}
  function has been called for the \code{\link{TesseractBaseAPI-class}}
  instance.
}
\references{
Leptonica \url{http://leptonica.com/}  
Tesseract \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}
\seealso{
\code{\link{SetImage}}
}
\examples{
}
\keyword{programming}
\keyword{IO}