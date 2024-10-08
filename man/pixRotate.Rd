\name{pixRotate}
\alias{pixRotateAMGray}
\alias{pixRotate}
\alias{pixTranspose}
\alias{pixFlipTB}
\alias{pixFlipLR}
\title{Rotate or Transpose a Pix Image}
\description{
  These functions allow the caller to rotate a Pix
  image. This can either be done by rotating the pixels
  within the same rectangle, or by transposing
  the rows and columns of the rectangular image
  so that rows become columns and columns become rows.
  Both change the contents in a similar manner, but
  the resulting image has different dimensions in general.

  The Flip functions reverse the order of the rows (TB) or the columns
  (LR).   These are done quickly in leptonica rather than bringing
  the data back to R.
  These can also be done in place (i.e. modify the existing image),
  create a new image, or for a second image.
}
\usage{
pixRotateAMGray(pix, angle, grayVal = 0L)
pixRotate(pix, angle = -pi/2, type = 1L, incolor = 1L, width = 0L, height = 0L)
pixFlipLR(pix, target = NULL)
pixFlipTB(pix, target = NULL)
}
\arguments{
\item{pix}{the Pix object created via \code{pixRead} or \code{\link{GetImage}}}
\item{angle}{a numeric value specifying the angle of rotation.
 These are in radians.  Positive values are clockwise, negative values anti-clockwise}
\item{grayVal}{an integer value specifying the ....}
\item{type}{how to rotate - by area map, shear or sampling}
\item{incolor}{whether to bring in white or black pixels the rotation
  leaves uncovered space from the background.}
\item{width,height}{ignore for now, i.e. leave as 0}
\item{target}{either a Pix object or NULL. If this is \code{NULL},
  a new Pix object is created and returned. If this is a Pix object,
  this is used to hold the modified contents of the Pix.
  This can be \code{pix} itself in which case the flip is done in place,
  i.e., in the original image, overwriting the original contents.
 }
}
\value{
A new Pix object.
}
\note{In the future, we may allow the caller to do some of these
  operations in place, i.e. to modify the input image.}
\references{
Leptonica \url{http://leptonica.com/}  
Tesseract \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}

\seealso{
\code{\link{pixRead}}
}
\examples{
f = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")
px = pixRead(f)

par(mfrow = c(2, 2))
plot(px)

pr = pixRotate(px)
plot(pr)

 # Here we flip the rows and columns of the image.
 # The result is that we have the "correct" dimensions for the new image
 # For the rotated image, the dimensions remain unchanged from the
 # original image.
pt = pixTranspose(px)
plot(pt)

 # We reverse the order of the columns.
pth = pixTranspose(px, horiz = TRUE)
plot(pth)
}
\keyword{programming}
\keyword{IO}
\concept{image processing}
