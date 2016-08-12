\name{getSmudges}
\alias{getSmudges}
\title{An Approach to Identifying Irrelevant Noisy Elements on the Page}
\description{
This function attempts to finds rows in the bounding box
matrix/data.frame that might be smudges/specs from the scanning process.
The approach this takes is to consider if they are sufficiently small
in both height and width to be less than a character.
This is ad hoc to say the least. One can implement additional or
alternative approaches and this is just offered as a utility.
}
\usage{
getSmudges(bbox, threshold = 5, charWidth = getCharWidth(bbox), charHeight = getCharHeight(bbox), anywhere = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{bbox}{the bounding box matrix/data from for the elements under
    consideration.}
  \item{threshold}{currently ignored }
  \item{charWidth}{a number for the typical character width on the page}
  \item{charHeight}{a number giving the typical character height on the page}
  \item{anywhere}{if \code{FALSE}, we compute the distance between
    potential specs and see if they are sufficiently far from another
    element (currently 3 characters away in any direction)}
}
\value{
 An integer vector giving the indices of any rows in the bounding box
 matrix/data.frame that are considered specs/smudges by this approach.
}
\author{
Duncan Temple Lang
}

\seealso{
\code{\link{getBoxes}}
}
%\examples{}
\keyword{IO}
