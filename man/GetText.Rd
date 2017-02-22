\name{GetText}
\alias{GetText}
\alias{GetBoxes}
\alias{GetBoxes,TesseractBaseAPI-method}
\alias{GetBoxes,character-method}
\alias{GetBoxes,Pix-method}
\alias{GetConfidences}
\alias{GetConfidences,TesseractBaseAPI-method}
\alias{GetConfidences,character-method}
\alias{GetConfidences,Pix-method}
\alias{GetAlternatives}
\alias{GetAlternatives,ResultIterator-method}
\alias{GetAlternatives,TesseractBaseAPI-method}
\alias{GetAlternatives,character-method}
\alias{GetAlternatives,Pix-method}

\title{Query the Current OCR Result to Get Text, Bounding Boxes, Confidence or Alternative Characters}
\description{
  These functions provide access to the information about each recognized element
  in a tesseract object.  These work at different element levels
  (characters, words, lines).
  We can get the recognized elements, their locations in the image, the
  confidence/certainty of the recognition, and possible alternative
  characters along with their confidences.
  
  There are methods that work on a the filename of an image or an
  existing tesseract object.  

%  \code{GetBoxes} gets all of the bounding boxes, i.e., for all the
%  detected elements in the image.
}
\usage{
GetBoxes(obj, level = 3L, keepConfidence = TRUE, ...)
GetConfidences(obj, level = 3L, ...)
GetText(obj, level = 3L, ...)
GetAlternatives(obj, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{obj}{the name of the file containing the image on which to do
 OCR
   or the \code{\link{TesseractBaseAPI-class}} class, obtained via a
  call to \code{\link{tesseract}}}
  \item{level}{the type of element to be recognized - block, paragraph,
    word or symbol.  This should be a value from the \code{\link{PageIteratorLevel}}
    enumerated constants.
  One can specify it as a value or  a name from that vector.
}
  \item{keepConfidence}{a logical value. If \code{TRUE}, the final
    column of the matrix returned by \code{GetBoxes} is the confidence associated with the text as
    determined by the OCR.}
  \item{\dots}{other arguments that are currently ignored.}
}
\value{
  \code{GetBoxes} returns a matrix with 4 columns
  giving the lower-left corner and upper right corner,
   xbottom, ybottom, xtop, ytop.
  
  %% \code{BoundingBox} returns a numeric vector with 4 elements
  %% corresponding to the lower-left corner and upper right corner.

  \code{GetConfidences} returns a numeric value between 0 and 100 indicating
  the confidence level of the recognized term.

  \code{GetText} returns the text of all the recognized elements.

  \code{GetAlternatives} returns a named numeric vector
  giving the confidence levels for the possible characters that are
  legitimate alternatives to the recognized value.  The names
  are the alternative characters and the value is the associated confidences.
}
\references{
Tesseract \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}

%\seealso{
%%\code{\link{GetIterator}}
%}
\examples{
 f = system.file("images", "OCRSample2.png", package = "Rtesseract")
 api = tesseract(f)
 Recognize(api)
 boxes = GetBoxes(api)
 rownames(boxes)
 boxes

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

