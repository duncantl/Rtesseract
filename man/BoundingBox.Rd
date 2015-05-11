\name{BoundingBox}
\alias{BoundingBox}
\alias{Confidence}
\alias{GetText}
\alias{GetAlternatives}
\title{Query the Current Result}
\description{
  These functions allow us to get information about the current
  item in the OCR result iterator.
  We can get the result itself, the confidence for the recognized
  result, 
  the location of the result in the image
}
\usage{
BoundingBox(ri, level = 3L)
Confidence(ri, level = 3L)
GetText(ri, level = 3L)
GetAlternatives(ri, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ri}{the \code{\link{ResultIterator-class}} class, obtained via a
  call to \code{\link{GetIterator}}}
  \item{level}{this is typically ignored, but provided for compatability
    with the way C routines are called.}
  \item{\dots}{other arguments that are ignored.}
}
\value{
  \code{BoundingBox} returns a numeric vector with 4 elements
  corresponding to the lower-left corner and upper right corner.

  \code{Confidence} returns a numeric value between 0 and 100 indicating
  the confidence level of the recognized term.

  \code{GetText} returns the text of the recognized term.

  \code{GetAlternatives} returns a named numeric vector
  giving the confidence levels for the possible terms that are
  legitimate alternatives to the recognized value.  The names
  are the alternative terms.
}
\references{
Tesseract \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}

\seealso{
\code{\link{GetIterator}}
}
\examples{
 f = system.file("images", "OCRSample2.png", package = "Rtesseract")
 api = tesseract(f)
 Recognize(api)
 boxes = lapply(api, BoundingBox, "word")
 names(boxes)
 boxes
}
\keyword{IO}

