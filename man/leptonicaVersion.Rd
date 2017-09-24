\name{leptonicaVersion}
\alias{leptonicaVersion}
\alias{getImageLibs}
\title{Information about the Leptonica Version and Image Format Support}
\description{
  These two functions allow us to query the meta-data about the
  leptonica library in use.
  They query the version information about leptonica itself
  and also the version of each of the image reading libraries it has
  been installed with.
}
\usage{
leptonicaVersion()
getImageLibs(asMatrix = FALSE)
}
\arguments{
\item{asMatrix}{a logical value that controls where the image library
  versions are returned as elements of a character vector or if the
 values are decomposed into a matrix giving the major, minor and patch
  numbers (where available).}
}
\value{
  \code{leptonicaVersion()} returns an integer vector with three element -
  the major, minor and patch numbers.

  \code{getImageLibs()} returns either a named character vector or a matrix.
  For the character vector, the names identify the image file format and the values identify the
  version of the corresponding library.
  The matrix is similar with a row for each of the image formats and
  columns for the major, minor and patch numbers.
  
}
\author{
Duncan Temple Lang
}
\seealso{
\code{\link{tesseractVersion}}
}
\examples{
 leptonicaVersion()

 getImageLibs()
}
\keyword{IO}

