\name{pixThresholdToBinary}
\alias{pixThresholdToBinary}
\alias{pixThresholdToValue}
\title{Threshold the Pixels in a Pix Image}
\description{
  These functions set a subset of the values in a \code{\link{Pix-class}}
  object to a single specific value.
  We can set all pixels with a value greater than threshold to a given
  value,  or all pixels with a valye less than the threshold to a given value.

  If \code{newValue} is greater than or equal to \code{threshold}, then pixels
  with a current value above \code{threshold} will be set to
  \code{newValue}
  and all other pixels will remain unchanged.

  Alternatively, if \code{newValue} is less than or equal to \code{threshold},
  all pixels with a current value less than \code{threshold} will
  be set to \code{newValue} and the pixels with a value
  greater than or equal to \code{threshold} will remain unchanged.

  For \code{pixThresholdToBinary}, pixels with a value less than
  \code{threshold} will be set to 1 (corresponding to white)
  and pixels with a value greater than or equal to \code{threshold}
  will be set to 0 (corresponding to black).
  
}
\usage{
pixThresholdToBinary(pix, threshold)
pixThresholdToValue(pix, threshold, newValue, target = NULL) 
}
\arguments{
  \item{pix}{a \code{\link{Pix-class}} image object}
  \item{threshold}{the threshold value which identifies which pixels to change}
  \item{newValue}{the new value for the pixels to take}
  \item{target}{either a \code{\link{Pix-class}} object or NULL.
          If a \code{Pix} is specified, this is used to store the
	  answer. Otherwise, a new Pix is created and returned.}
}
\value{
  These functions return a new \code{\link{Pix-class}} object.
}
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{pixRead}}
  \code{\link{GetInputImage}}
  \code{\link{pixAnd}}    
}
\examples{
f = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")
p1 = pixRead(f)
p1 = pixConvertTo8(p1)
bin = pixThresholdToBinary(p1, 150)
angle = pixFindSkew(bin)
}
\keyword{manip}
\concept{image processing}
