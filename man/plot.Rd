\name{plot}
\alias{plot,TesseractBaseAPI-method}
\alias{plot,OCRResults-method}
\title{Plot the results of an OCR}
\description{
  These functions are useful diagnostics of how well
  the OCR recognized the text.
  The method for a TesseractBaseAPI object can display both the image
  and all of the locations and rectangular regions (but not the text) for the elements the OCR recognized.
  The method for OCRResults (returned from a call to
  \code{\link{GetBoxes}})
  displays the text returned from the OCR as it appears on the
  page.   On other words, it doesn't show the background image
  but does show the text. 
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

