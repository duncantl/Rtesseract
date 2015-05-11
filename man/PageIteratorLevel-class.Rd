\name{PageIteratorLevel-class}
\Rdversion{1.1}
\docType{class}
\alias{PageIteratorLevel-class}
\alias{coerce,character,PageIteratorLevel-method}
\alias{coerce,numeric,PageIteratorLevel-method}

\title{Class \code{"PageIteratorLevel"}}
\description{
  An R-level mapping of the C++-enumerate constants
  that identify which terms to process in an OCR
  analysis of an image.
  These are block, para (for paragraph), textline (for a line of text),
  word and symbol (for an individual character).
  We can use the names of these values or the corresponding
  integer values in \code{PageIteratorLevel}.
}
\section{Objects from the Class}{
Objects can be created by calls of the form
\code{new("PageIteratorLevel", ...)}.
However, we typically use a character or integer value and
functions coerce these to a \code{PageIteratorLevel} instance
and validate and verify the value.
}
\section{Slots}{
  \describe{
    \item{\code{.Data}:}{Object of class \code{"integer"} ~~ }
  }
}
\section{Extends}{
Class \code{"\linkS4class{integer}"}, from data part.
Class \code{"\linkS4class{numeric}"}, by class "integer", distance 2.
Class \code{"\linkS4class{vector}"}, by class "integer", distance 2.
Class \code{"\linkS4class{data.frameRowLabels}"}, by class "integer", distance 2.
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "character", to = "PageIteratorLevel")}: ... }
    \item{coerce}{\code{signature(from = "numeric", to = "PageIteratorLevel")}: ... }
	 }
}
\references{
Tesseract documentatation - \url{http://zdenop.github.io/tesseract-doc/namespacetesseract.html#aa26c22b65cc9765a0e747120f4287fd7}
}
\author{
Duncan Temple Lang
}
\seealso{
\code{\link{lapply}}
}
\examples{
showClass("PageIteratorLevel")
}
\keyword{classes}
