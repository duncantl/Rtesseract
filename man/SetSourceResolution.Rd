\name{SetSourceResolution}
\alias{SetSourceResolution}
\alias{GetSourceYResolution}
\title{Set and Get the Pixels Per Inch Resolution for a Tesseract Image}
\description{
  These functions allows us to specify the resolution of the image in
  pixels per inch and also to query the vertical resolution.
  This allows tesseract to more accurately estimate font size.
}
\usage{
SetSourceResolution(api, ppi)
}
\arguments{
  \item{api}{an instance of the \code{\link{TesseractBaseAPI-class}}
    obtained from a call to \code{\link{tesseract}}}
  \item{ppi}{an integer giving the number  of pixels per inch in the image}
}
\value{
\code{SetSourceResolution} returns \code{NULL} and is used for its
side-effect  on the tesseract object.

\code{GetSourceYResolution} returns an integer value.
}
\references{
 \url{https://tesseract-ocr.github.io/a01281.html}
}
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{tesseract}}
}
\examples{

}
\keyword{programming}
\keyword{IO}
