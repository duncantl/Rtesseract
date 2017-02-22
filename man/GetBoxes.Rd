\name{GetBoxes}
\alias{GetBoxes}
\alias{GetBoxes,TesseractBaseAPI-method}
\alias{GetBoxes,character-method}
\alias{GetConfidences}
\alias{GetConfidences,TesseractBaseAPI-method}
\alias{GetConfidences,character-method}
\title{Get bounding boxes or confidence level for each recognized element}
\description{
  These provide access to the information for each recognized element
  in a tesseract object.
  There are methods that work on a the filename of an image or an
  existing tesseract object.
}
\usage{
GetBoxes(obj, level = 3L, keepConfidence = TRUE, ...)
}
\arguments{
  \item{obj}{the tesseract object, or the name of an image file}
  \item{level}{the type of element to be recognized - block, paragraph,
    word or symbol.  This should be a value from the PageIteratorLevel
    enumerated constants.}
  \item{keepConfidence}{a logical value. If \code{TRUE}, the final
    column of the matrix is the confidence associated with the text as
    determined by the OCR.}
  \item{\dots}{additional arguments for other methods}
}
%\details{}
\value{
  \code{GetConfidences} returns ..

  \code{GetBoxes} returns a matrix of left, bottom, right, top positions
  for each element, along with the text for each element in the  row names.
}
\references{
Tesseract API documentation
}
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{tesseract}}, \code{\link{Recognize}}
%  \code{\link{BoundingBoxes}}, \code{\link{ocr}}
}
\examples{
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
GetBoxes(f, "word")
GetBoxes(f, "symbol")
GetConfidences(f)

ts = tesseract(f)
Recognize(ts)
GetBoxes(ts)
GetConfidences(ts)
}
\keyword{IO}
