\name{toPDF}
\alias{toPDF}
\alias{toHTML}
\alias{toHOcr}
\alias{toOSD}
\alias{toTSV}
%\alias{toUNLV}
\title{Write Tesseract Results to Various Formats}
\description{
}
\usage{
toPDF(imgFile, outFile = removeExtension(imgFile), api = tesseract(, PSM_AUTO))
toHTML(imgFile, fontInfo = TRUE, outFile = removeExtension(imgFile), 
        api = tesseract(, PSM_AUTO))
toHOcr(imgFile, fontInfo = TRUE, outFile = removeExtension(imgFile), 
        api = tesseract(, PSM_AUTO))
toTSV(imgFile, fontInfo = TRUE, outFile = removeExtension(imgFile), 
       api = tesseract(, PSM_AUTO))
toOSD(imgFile, outFile = removeExtension(imgFile), api = tesseract(, PSM_AUTO)) 
}

\arguments{
  \item{imgFile}{a character vector of length 1 giving the name of the
  image file to process with OCR}
  \item{outFile}{the name of the output file, without an extension. The
  extension is added by the function.}
  \item{api}{an object of class 
        \code{\link{TesseractBaseAPI-class}} objected created via a call
	to \code{\link{tesseract}}.
	If this is not provided, a new tesseract instance is created,
  used and discarded. 
      }
  \item{fontInfo}{a logical value which if \code{TRUE} specifies that
    information about the fonts is included in the output.}
}
%\details{}
\value{
}
\references{
}
\author{
Duncan Temple Lang
}
%\note{}

\seealso{
}
\examples{
}
\keyword{IO}
\keyword{programming}

