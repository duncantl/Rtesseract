\name{SetRectangle}
\alias{SetRectangle}
\title{Focus the OCR on a Sub-Region of the Image}
\description{
  \code{SetRectangle} restricts the OCR to a sub-rectangle of the
  original image. After calling \code{SetRectangle}, the next
  recognition  done by the tesseract instance will only look at that
  region. This is useful when one knows a priori that only a subset
  of the image is of interest.
}
\usage{
SetRectangle(api, ..., dims = sapply(list(...), as.integer))
}
\arguments{
  \item{api}{an instance of the \code{\link{TesseractBaseAPI-class}}
    obtained from a call to \code{\link{tesseract}}}
  \item{\dots}{the specification of the rectangle as left, top, width
    and height.}
  \item{dims}{an alternative mechanism for specifying the location of
    the corners of the rectangle as a single object, a vector of integer
    values. The elements identify the left, top, width and height of the
    rectangle
    This should NOT be the coordinates
    of the top-left and bottom-right of the rectangle, i.e. \code{(x1, y1, x2, y2)}.
    The 3rd and 4th values are the width and height of the box.}
}
\value{
 \code{NULL}. The function is used for its side-effect on the tesseract instance.
}
\references{
\url{https://zdenop.github.io/tesseract-doc/group___advanced_a_p_i.html#ga284228c7e9d18bbbd3984d44e252d625}
}
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{tesseract}}, \code{\link{Recognize}},
  \code{\link{GetText}}
}
\examples{
f = system.file("images", "1990_p44.png", package = "Rtesseract")
ts = tesseract(f)
dims = GetImageDims(ts)
 # region chosen interactively
SetRectangle(ts, 500, 800, 1300, 800)
GetText(ts)
}
\keyword{IO}
\keyword{programming}
