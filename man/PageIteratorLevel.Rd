\name{PageIteratorLevel}
\alias{PageIteratorLevel}
\title{R version of the enumerated constants for the PageIteratorLevel in the tesseract library}
\description{
 This vector corresponds to a collection of enumerated constants in the tesseract C++ library.
}
\usage{data("PageIteratorLevel")}
\format{
  The format is:
 Named int [1:5] 0 1 2 3 4
 - attr(*, "names")= chr [1:5] "block" "para" "textline" "word" ...
}
\details{
We can use either the values in the vector
or the corresponding name in the call to \code{\link{ocr}} for the 
\code{level} argument.
}
\source{
The Tesseract  project \url{https://code.google.com/p/tesseract-ocr/}
}
\references{
The Tesseract  project \url{https://code.google.com/p/tesseract-ocr/}
}
\examples{
PageIteratorLevel["word"]
}
\keyword{datasets}
