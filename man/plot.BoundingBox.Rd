\name{plot.BoundingBox}
\alias{plot.BoundingBox}
\title{Plot function for a Bounding Box}
\description{
  The \code{plot.BoundingBox} function
  takes a bounding box 
  and an image and displays the subset of the image
  specified by the bounding box.
  The bounding box is a vector of length 4
  giving the pixel indices x1, y1, x2, y2
  of the corners of the rectangular bounding box.
  We use this to draw a separate plot for a term
  recognized by the OCR mechanism. This is useful
  for looking at misclassified terms.

  This  is unrelated to the tesseract API and is used
  for examining the region of the image in R.
}
\usage{
plot.BoundingBox(box, img, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{box}{ a vector of length 4 giving the x1, y1, and x2, y2
    coordinates of the sub-region.}
  \item{img}{the image object read using the appropriate function in
  the appropriate package for the image type. See \code{png},
    \code{rjpeg}, or \code{rtiff}.}
  \item{\dots}{additional arguments passed to the inherited \code{plot} methods.}
}
\value{
}
\references{
}
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{BoundingBox}}
}
\examples{

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
