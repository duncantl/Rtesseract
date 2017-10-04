\name{deskew}
\alias{deskew}
\alias{pixFindSkew}
\title{Align and Orient an Image}
\description{
  \code{deskew} rotates an image.  By default, it attempts
  to identify any skew and then rotates it so that
  the lines are horizontal and the edges are vertical.
}
\usage{
deskew(pix, binaryThreshold = 150, background = 255, angle = NA)
pixFindSkew(pix)
}
\arguments{n
  \item{pix}{a Pix objectx}
  \item{binaryThreshold}{a value between 0 and 255 that is used as the
    cut-off for creating the binary image.}
  \item{background}{a value specifying the color for any pixels
    that are exposed when the image is rotated.  255 is white; 0 is black.}
  \item{angle}{an angle (in degrees rather than radians). If this is
    not specified,  the skew is found using \code{pixFindSkew} having
    converted a copy of the \code{Pix} to a binary image to find any orientation}
}
\value{
  A new \code{Pix} object that has been rotated.
}
\references{
  \url{http://tpgit.github.io/UnOfficialLeptDocs/}
}
\author{
Duncan Temple Lang
}


\seealso{
  \code{\link{pixRead}}
  \code{\link{pixConvertTo8}}
}
\examples{
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
p = pixRead(f)
p2 = deskew(p, angle = 2)
plot(p2)

# Now deskew it.
p3 = deskew(p2)
plot(p3)


 # This is an example of where it matters.
f = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")
p1 = pixRead(f)
p2 = pixConvertTo8(p1)
p2 = deskew(p2)
p6 = Rtesseract:::findLines(p2, 51, 5, FALSE)
p = pixAddGray(p2, p6)
plot(p)
}
\concept{image processing}
\keyword{manip}
\keyword{hplot}
