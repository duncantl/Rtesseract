\name{GetIterator}
\alias{GetIterator}
\alias{ResultIterator-class}
\title{Get a ResultIterator for retrieving the OCR results}
\description{
 After the OCR engine processes the image and recognizes the characters,
 words and text lines, we access the results via a
 \code{ResultIterator}.  We can iterate over this using \code{\link{lapply}}
 and use functions to query the results of current result.
}
\usage{
GetIterator(api, recognize = TRUE)
}
\arguments{
  \item{api}{the \code{TesseractBaseAPI} ojbect created by a call to
    \code{\link{tesseract}}}
  \item{recognize}{a logical value. If \code{TRUE}, we ensure
    \code{\link{Recognize}} is called to process the image.
    If \code{FALSE}, the function raises an error if
    \code{\link{Recognize}}
     has not been called. The class of the error is
     \code{TesseractRecognizeNotCalled},
     which can be caught using \code{\link[base]{tryCatch}}.
     However, it is more convenient to just force the call to
     \code{\link{Recognize}}
     in this situation via \code{recognize = TRUE}.
     }
  }
}

\details{
  The result iterator is a reference to a C++ object.
  When manipulate it in a call, its underlying state changes.
  This is not side-effect free.
  Furthermore, as we iterate over the results, the iterator
  "points" to the current result and then the functions
  to access this are passed the result iterator.
  See, for example, \code{\link{Confidence}}.
}
\value{
An object of class \code{ResultIterator}.
}
\references{
  Tesseract \url{https://code.google.com/p/tesseract-ocr/}
  \url{http://zdenop.github.io/tesseract-doc/classtesseract_1_1_result_iterator.html}
}
\author{
Duncan Temple Lang
}


\seealso{
  \code{\link{lapply}}
  \code{\link{tesseract}}
}
\examples{
 f = system.file("images", "OCRSample2.png", package = "Rtesseract")
 api = tesseract(f)
 Recognize(api)
 ri = GetIterator(api)
 lapply(ri, Confidence, "word")
 lapply(ri, Confidence, "symbol")
}
\keyword{programming}
\keyword{IO}
\keyword{iteration}
