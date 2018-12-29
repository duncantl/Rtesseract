\name{GetConfidenceColors}
\alias{GetConfidenceColors}
\title{Get Colors for Displaying Confidence of OCR}
\description{
  This is a convenience function for computing the 
  color values to indicate the confidence/certainty of each of the
  recognized elements in the OCR.
  This computes the color palette, by default, and then maps
  the confidence values into bins.
  By default, the more green the value, the more certainty.
  A caller can specify different end points of the color range
  (via \code{colorEnds}).
}
\usage{
GetConfidenceColors(bbox, confidences = bbox[, "confidence"],
                    numColors = 10,
                    colors = colorRampPalette(colorEnds)(numColors),
                    colorEnds = getOption("OCRConfidenceColors", c("red", "lightgreen")),  
                    intervals = quantile(confidences, seq(0, 1, by = 1/numColors)))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{bbox}{the matrix of matched elements returned from \code{\link{GetBoxes}}}
  \item{confidences}{the vector of confidence values. These are
    extracted from \code{bbox} or can be specified directly as the
    return value from \code{\link{GetConfidences}}}
  \item{numColors}{the number of colors to use in the color palette}
  \item{colors}{a vector of color values (as a character vector) in case
    the caller wants to specify the colors directly.}
  \item{colorEnds}{a character vector of two colors giving the
    color for the minimum and maximum confidence. These are  used to interpolate the
    other color values for the confidences. The caller can specify these
    two color values via the R session option named \code{OCRConfidenceColors}. 
  }
  \item{intervals}{the bins by which to group the confidences}
}
\value{
  A character vector of colors corresponding to the rows in \code{bbox}
  or elements in \code{confidences}
}
\author{
Duncan Temple Lang
}
\seealso{
  \code{\link{GetConfidences}}, \code{\link{GetBoxes}},
  \code{\link{plot}}
}
\examples{
f = system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract")
ts = tesseract(f)
bbox = GetBoxes(ts)
colors = GetConfidenceColors(bbox) 
plot(ts, bbox = bbox, border = colors)

m = plot(ts, img = NULL, bbox = bbox, border = colors)
rect(m[,1], m[,2], m[,3], m[,4], col = colors)
}
\keyword{programming}
\keyword{IO}
\keyword{graphics}
