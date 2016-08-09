\name{getBoxes}
\alias{getBoxes}
\alias{getBoxes,TesseractBaseAPI-method}
\alias{getBoxes,character-method}
\alias{getConfidences}
\alias{getConfidences,TesseractBaseAPI-method}
\alias{getConfidences,character-method}
\title{Get bounding boxes or confidence level for each recognized element}
\description{
  These provide access to the information for each recognized element
  in a tesseract object.
  There are methods that work on a the filename of an image or an
  existing tesseract object.
}
\usage{
getBoxes(obj, level = 3L, ...)
}
\arguments{
  \item{obj}{the tesseract object, or the name of an image file}
  \item{level}{the type of element to be recognized - block, paragraph,
    word or symbol.  This should be a value from the PageIteratorLevel
    enumerated constants.}
  \item{\dots}{additional arguments for other methods}
}
%\details{}
\value{
  \code{getConfidences} returns ..

  \code{getBoxes} returns a matrix of left, bottom, right, top positions
  for each element, along with the text for each element in the  row names.
}
\references{
Tesseract API documentation
}
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{tesseract}}, \code{\link{Recognize}},
  \code{\link{BoundingBoxes}}, \code{\link{ocr}}
}
\examples{
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
getBoxes(f, "word")
getBoxes(f, "symbol")
getConfidences(f)

ts = tesseract(f)
Recognize(ts)
getBoxes(ts)
getConfidences(ts)
}
\keyword{IO}
