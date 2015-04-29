\name{ocr}
\alias{ocr}
\title{Perform OCR on an image}
\description{
This is the primary high-level function for performing OCR on a document.
}
\usage{
ocr(img, opts = character(), level = PageIteratorLevel["word"])
}
\arguments{
  \item{img}{the file name of the image to be processed}
  \item{opts}{a character vector of \code{name = value} pairs specifying tesseract variables and values.}
  \item{level}{an integer value specifying what level/unit to return the results for, e.g.,
      paragraph, word, character. See  \code{PageIteratorLevel}}
}
\value{
 Currently, a numeric vector whose names are the characters/words that were recognized
 and the values are the associated confidence levels.
}
\references{
The Tesseract  project \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}

% \seealso{}

\examples{
 
 f = system.file("images", "IMG_1234.jpg", package = "Rtesseract")
 ocr(f, opts = c("tessedit_char_whitelist" = "0123456789."), "symbol")

}
