\name{lapply}
\alias{lapply}
\alias{lapply,ResultIterator-method}
\alias{lapply,TesseractBaseAPI-method}
\title{Method for Iterating over a ResultIterator}
\description{
  This function allows us to loop over the results
  in the OCR result iterator and query each result
  using a given function.
  We can get the confidence level for the predicted  term (word, symbol,
  etc.),   the rectangular bounding box for the term,
  possible alternatives for the term.
}
\usage{
lapply(X, FUN, ...) # level = "word",
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{X}{a \code{\link{ResultIterator-class}} object obtained via a
    call to \code{\link{GetIterator}}.}
  \item{FUN}{the function to be applied to each successive result in the
    \code{ResultIterator}. This can also the address of a compatible C
    routine.  This can be significantly faster.
    The C routine is called with the ResultIterator object and the
    level at which the OCR is working (word, symbol, etc.).
    It needs to return an R object, i.e. a \code{SEXP}.
    The C routine can be specified by name and is resolved by a
    call to \code{\link[base]{getNativeSymbolInfo}}}
  \item{level}{either a number or character vector that maps to a
    \code{PageIteratorLevel} object. This is an enumerated constant
    mapping the concept of a term to a number to be used in the C++ code.}
  \item{\dots}{additional arguments}
}
\value{
 A list with an element corresponding to each result in the OCR iterator.
}
\references{
Tesseract \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}

\seealso{
\code{\link{ResultIterator-class}}
}
\examples{
 f = system.file("images", "OCRSample2.png", package = "Rtesseract")
 api = tesseract(f)
 Recognize(api)
 ri = GetIterator(api)
 lapply(ri, Confidence, "word")
 conf = lapply(ri, Confidence, "symbol")
 names(conf)

 lapply(ri, BoundingBox, "symbol")


 sym = getNativeSymbolInfo("r_getConfidence")
 conf = lapply(ri, sym$address, "word")
}
\keyword{programming}
\keyword{iteration}