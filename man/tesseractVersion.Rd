\name{tesseractVersion}
\alias{tesseractVersion}
\title{Get the version information of the tesseract library}
\description{
This returns the version information for the tesseract library
that is in use in this package.
}
\usage{
tesseractVersion(patch = FALSE, runTime = TRUE)
}
\arguments{
\item{patch}{a logical value. If \code{FALSE}, the information
  identifying the patch version is removed, e.g., 3.05.01 is returned as
  3.05.}
\item{runTime}{a logical value.  If \code{TRUE}, we query the version
  at run-time via the Tesseract API. If \code{FALSE}, we use the version
 information computed when the package was built from source.}
}
\value{
 A character string (i.e., with a single element)
}
\references{
The Tesseract  project \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}

%\seealso{}

\examples{
 tesseractVersion()
}
\keyword{programming}

