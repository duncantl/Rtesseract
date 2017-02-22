\name{SetOutputName}
\alias{SetOutputName}
\title{Set the Output Name for Any Content Written by Tesseract}
\description{
  When a tesseract object is used to generate output to a file,
  it uses this output prefix for each file it generates.
  This is not used directly very often, but in the \code{ProcessPages}
  mechanism used in the \code{\link{toPDF}} and related functions to
  generate different formats of the results from the OCR.
  However, we specify the output name in those functions.
  This is part of the tesseract API and so included here.
 }
\usage{
SetOutputName(api, filename)
}
\arguments{
  \item{api}{an instance of the \code{\link{TesseractBaseAPI-class}}
    obtained from a call to \code{\link{tesseract}}}  
  \item{filename}{the name of the output file, without the extension}
}
\value{
  No result, but used for its side-effect.
}
\references{
 \url{http://zdenop.github.io/tesseract-doc/classtesseract_1_1_tess_base_a_p_i.html}
}
\author{
Duncan Temple Lang
}
\seealso{
\code{\link{toPDF}}, etc.
}
\examples{
f = system.file("images", "OCRSample2.png", package = "Rtesseract")
ts = tesseract(f)
SetOutputName(ts, "tmp")
}
\keyword{IO}
\keyword{programming}
