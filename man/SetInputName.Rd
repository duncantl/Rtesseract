\name{SetInputName}
\alias{SetInputName}
\alias{GetInputName}
\alias{SetImage}
\title{Load an Image into the Tesseract Instance}
\description{
  These functions provide different ways to specify which
  image to perform the OCR on and also to query the name of the
  current image file being processed.
}
\usage{
SetInputName(api, name, check = TRUE, load = TRUE)
GetInputName(api)
SetImage(api, pix) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{api}{an instance of the \code{\link{TesseractBaseAPI-class}}
    obtained from a call to \code{\link{tesseract}}}
  \item{name}{a character vector of length 1 that gives the name of the
    image file to be processed}
  \item{check}{a logical value controlling whether the value of
    \code{name} must identify an actual file that exists}
  \item{load}{a logical value indicating whether to actually read the image}
  \item{pix}{a \code{\link{Pix-class}} object, typically created via
    \code{\link{pixRead}}. This is the contents of the image.
  }
}
\value{
  \code{GetInputName} returns a character vector of length 1 (a string)
   with the name of the image file that was previously loaded. This
   could be empty if the image was loaded directly as a \code{Pix} object.
}
\references{
 \url{http://zdenop.github.io/tesseract-doc/classtesseract_1_1_tess_base_a_p_i.html}
}
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{tesseract}}, \code{\link{GetText}}
}
\examples{
f = system.file("images", "OCRSample2.png", package = "Rtesseract")
p = pixRead(f)
ts = tesseract()
GetInputName(ts) # NA
SetImage(ts, p)
GetInputName(ts) # NA
SetInputName(ts, f)
GetInputName(ts)
}
\keyword{IO}
\keyword{programming}

