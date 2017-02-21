\name{GetText}
\alias{GetBoxes}
\alias{GetConfidences}
\alias{GetText}
\alias{GetAlternatives}
\title{Query the Current Result}
\description{
  These functions allow us to get information about the current
  item in the OCR result iterator.
  We can get the result itself, the confidence for the recognized
  result, the location of the result in the image

  \code{BoundingBoxes} gets all of the bounding boxes, i.e., for all the
  detected elements in the image.
}
\usage{
GetBoxes(obj, level = 3L, keepConfidence = TRUE, ...)
GetConfidences(obj, level = 3L, ...)
GetText(obj, level = 3L, ...)
GetAlternatives(obj)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{obj}{either the location of an image
  file, or a \code{\link{TesseractBaseAPI-class}} class, obtained via a
  call to \code{\link{tesseract}}}
  \item{level}{this level determines whether
  we recognize blocks, paragraphs, words or characters, i.e., the unit
  to be reconized as a single entity.
  This is a value from enumerated constant type
  \code{\link{PageIteratorLevel}}.
  One can specify it as a value, a names from that vector.
  }
  \item{keepConfidence}{logical, should the confidences be retained in
	the output}
  \item{\dots}{other arguments that are passed to \code{\link{tesseract}}}
}
\value{
  \code{GetBoxes} returns a matrix with 4 columns
  giving the lower-left corner and upper right corner,
   xbottom, ybottom, xtop, ytop.
  
  %% \code{BoundingBox} returns a numeric vector with 4 elements
  %% corresponding to the lower-left corner and upper right corner.

  \code{GetConfidences} returns a numeric value between 0 and 100 indicating
  the confidence level of the recognized term.

  \code{GetText} returns the text of the recognized term.

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

\seealso{
%%\code{\link{GetIterator}}
}
\examples{
f = system.file("images", "OCRSample2.png", package = "Rtesseract")

# Constructing an API object that can be reused
api = tesseract(f)
Recognize(api)
boxes = GetBoxes(api)
rownames(boxes)
boxes

## Using the image name
boxes2 = GetBoxes(f)


}
\keyword{IO}

