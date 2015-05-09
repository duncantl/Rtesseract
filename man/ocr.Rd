\name{ocr}
\alias{ocr}
\title{Perform OCR on an image}
\description{
This is the primary high-level function for performing OCR on a document.
}
\usage{
ocr(img, level = PageIteratorLevel["word"], alternatives = FALSE,
         opts = sapply(list(...), as, "character"), ...)
}
\arguments{
  \item{img}{the file name of the image to be processed}
 \item{alternatives}{a logical value that controls whether the possible alternatives for each recognized element are returned. This allows us to compare the "confidence" we have in the predicted text relative to the other possibilities.}
  \item{opts}{a character vector of \code{name = value} pairs specifying tesseract variables and values.}
  \item{\dots}{\code{name = value} pairs for specifying tesseract options individually rather than in a character vector via \code{opts}.}
  \item{level}{an integer value specifying what level/unit to return the results for, e.g.,
      paragraph, word, character. This can also be a character string giving the name of an element in \code{PageIteratorLevel}}
}
\value{

 If \code{alternatives} is \code{FALSE} (the default), 
 this returns a numeric vector whose names are the elements 
 (characters, words, lines, paragraphs, blocks) that were recognized
 and the values are the associated confidence levels.

 If \code{alternatives} is \code{TRUE}, a \code{list} is returned.
 The names of the elements of the list are the recognized text.
 Each element is a named numeric vector. 
 The names are the different possible values of the recognized element;
 the numeric value is the confidence associated with possible choice.
}
\references{
The Tesseract  project \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}

% \seealso{}

\examples{
# 
 f = system.file("images", "OCRSample.tiff", package = "Rtesseract")
 o = ocr(f, "word")
 names(o)
 summary(o)  # confidence levels

 ans = ocr(f, "word", boundingBox = TRUE)

 f = system.file("images", "IMG_1234.jpg", package = "Rtesseract")
 o = ocr(f, "symbol", opts = c("tessedit_char_whitelist" = "0123456789."))

 ans = ocr(f, "word", alternatives = TRUE, "tessedit_char_whitelist" = "0123456789.")

 ans = ocr(f, "word", boundingBox = TRUE, "tessedit_char_whitelist" = "0123456789.")
}
