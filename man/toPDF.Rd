\name{toPDF}
\alias{toPDF}
\alias{toHTML}
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
toTSV(imgFile, fontInfo = TRUE, outFile = removeExtension(imgFile), 
       api = tesseract(, PSM_AUTO))
toOSD(imgFile, outFile = removeExtension(imgFile), api = tesseract(, PSM_AUTO)) 
}

\arguments{
  \item{imgFile}{}
  \item{outFile}{}
  \item{api}{}
  \item{fontInfo}{}
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

