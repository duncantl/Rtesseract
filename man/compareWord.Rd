\name{compareWord}
\alias{compareWordInfo}
\alias{compareWord}
\alias{compareWords}
\title{Compares OCR words to truth}
\description{
  If we have the true text, we can use \code{compareWords}
  and other functions to compare the OCR results to the truth
  and determine which symbols were matched incorrectly.
  The results can then be displayed on the image and the
  incorrect symblols identified.

  \code{compareWords} process a collection of words;
  \code{compareWordInfo} processes a single word and the corresponding
  true/actual value for the word.
}
\usage{
compareWords(ocr, truth)
compareWordInfo(ocr, truth)
}
\arguments{
  \item{ocr}{the words from the OCR classification}
  \item{truth}{the true words}
}
\value{
  \code{compareWords} returns a data frame.
  
}
\references{
Tesseract \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}


\seealso{
\code{\link{ocr}}
}
\examples{
}
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
