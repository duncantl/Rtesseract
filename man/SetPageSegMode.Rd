\name{SetPageSegMode}
\alias{SetPageSegMode}
\alias{GetPageSegMode}
\title{Set and Query the Page Segmentation Mode for Tesseract Instance}
\description{
  These functions allow us to set at what level the OCR is done -
  lines, words, characters, etc.
}
\usage{
SetPageSegMode(api, mode)
GetPageSegMode(api)
}
\arguments{
  \item{api}{an instance of the \code{\link{TesseractBaseAPI-class}}
    obtained from a call to \code{\link{tesseract}}}  
  \item{mode}{a value of class \code{PageSegMode} or that can be coerced
  to such a value. This can be an integer or a character string
  corresponding to the values or names of the vector
  \code{PageSegModeValues}
 or can be any of the corresponding variables, e.g. \code{PSM_OSD_ONLY}, etc.
}
}
\value{
  \code{SetPageSegMode}  is used for its side-effect of setting the
  value in the tesseract instance.
  
  \code{GetPageSegMode} returns an object of class \code{PageSegMode}.
}
\references{
 API \url{http://zdenop.github.io/tesseract-doc/classtesseract_1_1_tess_base_a_p_i.html}
}
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{tesseract}},   \code{\link{Recognize}},
    \code{\link{GetText}}, etc.
}
\examples{
f = system.file("images", "1990-10.png", package = "Rtesseract")
ts = tesseract(f)
GetPageSegMode(ts)
b = GetBoxes(ts)

# See if any of the matched elements are blank spaces corresponding to lines
i = grep("^[[:space:]]*$", rownames(b))

# Change to PSM_AUTO mode
SetPageSegMode(ts, 'PSM_AUTO')
GetPageSegMode(ts)
b1 = GetBoxes(ts)
# Find the potential lines
i = grep("^[[:space:]]*$", rownames(b1))
b1[i,]

# The last of these is the large black rectangle at the bottom of the
# page due to the page not covering the entire scanner bed.
}
\keyword{IO}
\keyword{programming}

