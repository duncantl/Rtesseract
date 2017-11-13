\name{getLines}
\alias{getLines}
\alias{findLines}

\title{Find and Determine Vertical and Horizontal Line Segments in an Image}

\description{
  These functions use leptonica Pix functions to identify vertical or
  horizontal lines in an image and then extract the coordinates of these
  segments, combining close segments as appropriate.
}
\usage{
getLines(pix, hor, vert, lineThreshold = 0.1, fraction = 0.5,
         gap = 0.02, ..., asIs = is(pix, "AsIs"), horizontal = hor > vert)
}
\arguments{
  \item{pix}{the image, as a \code{\link{Pix-class}} object, or
  coercable to one, e.g., the name of an image file}
  \item{hor,vert}{the horizontal and vertical dimensions defining a
    window used to search for lines. Larger area windows mean 
    a potential line has to occupy more pixels to be considered a line.
    This reduces the false positives.
    If \code{asIs} is \code{TRUE}, \code{horiz} and \code{vert} are not used.
  }
  \item{lineThreshold}{the proportion or number of pixels in the binary image
    matrix that must be black to be considered a line. Smaller values
    allow detecting short line segments.  Too small means false positives.
  }
  \item{fraction}{when collapsing rows/columns in the matrix to a single
  "line" in the image, the proportion of the cells that have to be black
  for the corresponding cell in result to be black.}
  \item{gap}{the number of pixels below which two segments are
  considered one, i.e., when the end of one segment is within gap pixels
  of the start of the other segment.}
  \item{\dots}{additional arguments passed to \code{findLines}}
  \item{asIs}{indicates if the image passed via \code{pix} has already be
  processed to contain only the images (\code{TRUE}).  Otherwise,
  \code{pix} is passed to \code{findLines} and we extract the lines from
  the resulting image}
  \item{horizontal}{a logical value indicating whether we are looking
    for horizontal or vertical lines. This can be useful if the \code{pix}
    value is the preprocessed image that contains only the lines.
    In this case, we don't have to specify \code{horiz} and \code{vert}
    but just \code{horizontal}.
  }
}
\value{
 a list of matrices, each containing 4 columns giving x0, y0, x1, y1 coordinates
}
\references{
\url{http://www.leptonica.com/line-removal.html}
}
\author{
Duncan Temple Lang
}

\seealso{
\code{\link{pixGetPixels}}
}
\examples{
f = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")

p1 = pixRead(f)
p1 = pixConvertTo8(p1)

bin = pixThresholdToBinary(p1, 150)

angle = pixFindSkew(bin)
p2 = pixRotateAMGray(p1, angle[1]*pi/180, 255)

h = findLines(p2, 101, 1, TRUE, erode = integer())
plot(h)

 # Compute the end points of the line segments
hlines = getLines(h, asIs = TRUE, horizontal = TRUE)
hl = do.call(rbind, hlines)
apply(hl, 1, function(x) lines(x[c(1, 3)], nrow(p2) - x[c(2,4)], col = "red"))

 # Here we allow a larger gap and also fewer of the cells in a group of
 # rows need to have a black pixel for the corresponding pixel in the
 # line to be black.
hlines = getLines(h, asIs = TRUE, horizontal = TRUE, gap = 250, fraction = .2)
hl = do.call(rbind, hlines)
apply(hl, 1, function(x) lines(x[c(1, 3)], nrow(p2) - x[c(2,4)], col = "red"))


vlines = getLines(p2, 1, 101)

}

\keyword{IO}
\concept{image processing}
