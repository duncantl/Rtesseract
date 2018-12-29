\name{tesseractQueryState.Rd}
\alias{GetDatapath}
\alias{GetDataPath}
\alias{GetInitLanguages}
\alias{hasRecognized}
\alias{oem}
\alias{oem<-}
\alias{IsValidWord}
\alias{GetThresholdedImage}
\alias{IsValidWord}

%

\title{Query the State of a Tesseract Object}
\description{
  These functions allow us to query the current state and settings
  of a tesseract OCR object.

  There are other functions in other help pages that are related to
  setting and querying the state.

  We can query the location of the tesseract data files where
  the training and configuration files are located.
  These can be set via the environment variable \code{TESSDATA_PREFIX},
  or the \code{datapath} argument to \code{\link{tesseract}} and
  \code{\link{Init}}.

  The \code{oem} allows us to query the OcrEngineMode that was set
  during the initialization.

  \code{GetInitLanguages} queries the languages specified in the
  initialization.

  \code{IsValidWord} queries whether a word is consider valid
  given the current settings and dictionary in use.
}
\usage{
GetDatapath(api)
hasRecognized(api)
oem(api)
GetInitLanguages(api)

IsValidWord(api, word)

GetThresholdedImage(api)
}
\arguments{
  \item{api}{the instance of the  \code{\link{TesseractBaseAPI-class}}
    in which to perform the operations.}  
  \item{word}{a character vector of words whose validity we want to
    check}
}

\author{
  Duncan Temple Lang
}

\seealso{
\code{\link{tesseract}}
}
\keyword{IO }
\keyword{programming}

