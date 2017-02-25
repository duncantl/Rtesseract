\name{GetCharWidth}
\alias{GetCharWidth}
\alias{GetCharHeight}
\title{
Utlities for Computing Typical Character Height and Width on this Page
}
\description{
  These functions provide a simple way to calculate the typical
  height and width of the characters recognized on the current page.
}
\usage{
GetCharWidth(bbox, fun = median, onlyAlphaNumeric = TRUE)
GetCharHeight(bbox, fun = median, onlyAlphaNumeric = TRUE)
}
\arguments{
  \item{bbox}{the matrix/data.frame of bounding boxes of the elements on
  the page}
  \item{fun}{a function to compute the "typical" value, e.g., the median
    or mean. It is called with a numeric vector.}
  \item{onlyAlphaNumeric}{a logical value to control whether we only
    consider "regular" characters and not diacritics and other
    characters that the OCR may have inferred}
}
\value{
 a scalar numeric value
}
\author{
Duncan Temple Lang
}
\seealso{
\code{\link{GetBoxes}}, \code{\link{tesseract}}
}
%\examples{}
\keyword{IO}
