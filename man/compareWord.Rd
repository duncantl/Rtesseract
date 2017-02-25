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
  \code{compareWords} returns a data frame
  with a row for each symbol/character that was different between
  the OCR version and the truth.
  The data frame contains
  \item{ocr}{the character recognized by the OCR system, incorrectly}
  \item{truth}{the true value of the character}
  \item{position}{the index in the word of the misclassified character/symbol}
  \item{wordIndex}{the index of the word in which the misclassification occured}
  \item{trueWord}{the value of the true word}
  \item{ocrWord}{the value of the word as recognized by the OCR system}
  \item{symbolIndex}{the index of the character/symbol in the entire set of symbols}  
}
\note{
  This function does not yet handle the case where the OCR and true words
  do not have the same length.
}
\references{
Tesseract \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}

\seealso{
\code{\link{tesseract}}, \code{\link{GetText}}, \code{\link{GetConfidences}}
}
\examples{
compareWords(c("Duncin", "Temple", "Lung"), c("Duncan", "Temple", "Lang"))
}
\keyword{programming}

