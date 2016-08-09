\name{bboxToDF}
\alias{bboxToDF}
\alias{orderBBox}
\title{Utility Function for Manipulating Bounding Box Collection}
\description{
We typically return the bounding boxes of the elements recognized by
tesseract on an image as a matrix, with the text for each element
in the rownames. A data frame would not allow duplicate text
as row names. The \code{bboxToDF} function converts the matrix
version to a data frame, adding the text as a 5th column.

It can be useful to have the bounding boxes as a data frame
when we \code{\link[base]{split}} the rows based on some criteria.

\code{orderBBox} is a convenient function for
easily ensuring the rows in a bounding box are arranged
from left to right or top to bottom or vice versa.
This is a simple version of
  \code{bbox[ order(bbox[, col], decreasing = TRUE/FALSE), ]}
}
\usage{
bboxToDF(bb)
orderBBox(bbox, colName = "bottom", decreasing = TRUE) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{bb}{the bounding box as a matrix}
  \item{bbox}{the bounding box as a matrix or data.frame}
  \item{colName}{the name of the column of the bounding box to order the
    rows by.}
  \item{decreasing}{}
}
\value{
 \code{bboxToDF} returns a data frame with the text for each bounding
 box in a 5th column named \code{text}.

 \code{orderBBox} returns the same object as its input, but in different
 row order.
}

\author{
Duncan Temple Lang
}
\seealso{
  \code{\link{getBoxes}}
}
\examples{
}
\keyword{IO}

