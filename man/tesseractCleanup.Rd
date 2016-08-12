\name{tesseractCleanup}
\alias{End}
\alias{Clear}
\alias{ClearAdaptiveClassifier}
\alias{ClearPersistentCache}

\title{Cleanup Aspects of a Tesseract Object}
\description{
  These functions allow one to clean up different memory and results
  associated with a tesseract object.
  They are used to release resources when we know we don't need them
  again. For the most part, we do not need to explicitly invoke
  these but remove the tesseract object and allow it to be garbage
  collected by R. However, these functions allow us to
  cleanup aspects of the tessearct object without throwing it all away.
  This way, we can reuse the same tesseract object, e.g. , on another
  image.
}
\usage{
Clear(api)
ClearAdaptiveClassifier(api)
End(api)
ClearPersistentCache(...)
}
\arguments{
  \item{api}{the instance of the  \code{\link{TesseractBaseAPI-class}}
    in which to perform the operations.}
  \item{\dots}{any arguments are ignored. This is to allow a caller
    specify a Tesseract object eventhough this applies to all of them.}
}

\value{
  The value of these functions should be ignored as it is the side-effect that is desired.
}
\author{Duncan Temple Lang}
\seealso{
\code{\link{tesseract}}
}
\keyword{IO}
\keyword{programming}
