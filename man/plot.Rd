\name{plot}
\alias{plot,TesseractBaseAPI-method}
\title{Plot the results of an OCR}
\description{
  This function is a useful diagnostic of how well
  the OCR recognized the text.
  It can display both the image and the rectangular regions
  for the elements the OCR recognized.
}
%\usage{}
\value{
  This method returns the matrix
  of bounding  boxes with values consistent
  with the user-coordinates of the plot (i.e.,
  the top and bottom mapped to the plot's coordinates
  rather than the top as 0).
  This can be used to further annotate the plot,
  e.g., enhance the rectangles for the bounding box elements
  using \code{rect}.
}
\author{
Duncan Temple Lang
}
\seealso{
  \code{\link{tesseract}}
  \code{\link{Recognize}}  
}
\keyword{IO}
\keyword{programming}
\keyword{graphics}

