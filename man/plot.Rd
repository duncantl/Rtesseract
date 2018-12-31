\name{plot}
\alias{plot,TesseractBaseAPI-method}
\alias{plot,OCRResults-method}
\alias{showPoints}
\title{Plot the results of an OCR}
\description{
  These functions are useful diagnostics of how well the OCR recognized the text.
  The method for a TesseractBaseAPI object can display both the image
  and all of the locations and rectangular regions (but not the text) for the elements the OCR recognized.
  The method for OCRResults (returned from a call to  \code{\link{GetBoxes}})
  displays the text returned from the OCR as it appears on the
  page.   In other words, it doesn't show the background image
  but does show the text.
  \code{showPoints} can be used to highlight a subset of entries in the
  results of the OCR that are of interest. The function draws large
  circles centered at those points so one can quickly identify them
  visually on the original image.
}
\usage{
showPoints(x, top = par()$usr[4], radii = top* 0.05, fg = "red",
            inches = FALSE, addGuides = !inches, ...)
}
\arguments{
\item{x}{the subset of the matrix or data.frame of results from the OCR
  giving the coordinates of the items we want to identify via
  \code{showPoints}}
\item{top}{the number of pixels in the image, providing the value to map
  the vertical coordinates in \code{x} to the coordinates of the plot,
  i.e. subtract the values from this \code{top} value.}
\item{radii}{the radius of the circles that are drawn at the points in
  \code{x}.
   This value is passed to  in the call to \code{\link[graphics]{symbols}} as the
   argument for \code{radii}.}
 \item{fg}{the color for drawing the circles}
 \item{inches}{a logical value.  See \code{inches} in the help for \code{\link[graphics]{symbols}}}
 \item{addGuides}{a logical value that controls whether we add 3 lines
   from the center of each point being shown/highlighted to help
   visually identify the circle and the corresponding text.}
 \item{\dots}{additional arguments passed to \code{\link[graphics]{symbols}}}
}
\value{
  The plot methods return the matrix
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

