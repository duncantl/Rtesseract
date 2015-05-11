\name{tesseract}
\alias{tesseract}
\alias{TesseractBaseAPI-class}
\alias{SetImage}
\alias{Recognize}
\alias{SetRectangle}
\alias{SetSourceResolution}
\alias{GetInputName}
\alias{SetInputName}
\alias{GetDatapath}
\alias{GetInitLanguages}
\alias{ReadConfigFile}
\alias{GetSourceYResolution}
\alias{IsValidWord}
\alias{Init}
\alias{End}
\alias{Clear}
\alias{plot,TesseractBaseAPI-method}
%\alias{SetVariables}

\title{Top-level Tesseract OCR API Functions and Classes}
\description{
  To perform OCR on an image, we need a Tesseract API object
  and then can call its methods.
  
}
\usage{
tesseract(image = character(), ..., init = TRUE)

SetImage(api, pix)
Init(api, lang = "eng")
SetRectangle(api, ..., dims = sapply(list(...), as.integer))
SetSourceResolution(api, ppi)
Recognize(api)

SetInputName(api, name)
GetInputName(api)
GetDatapath(api)
GetInitLanguages(api)
ReadConfigFile(api, files)
GetSourceYResolution(api)

IsValidWord(api, word)

Clear(api)
End(api)
}
\arguments{
  \item{image,pix}{either a \code{\link{Pix-class}} object, or a file name
    from which to read the image. Specifying the name of a file also
    arranges to call \code{\link{SetInputName}} and so the
    \code{\link{TesseractBaseAPI-class}}
    instance knows where the image is located. This means we can query
    it.
    If speciyfing the name of a file, make certain to assign the result
    to a variable that persists until \code{Recognize} is called for
    this \code{\link{TesseractBaseAPI-class}} instance.
    In the future, we will ensure that garbage collection protects the
    image, but it is not the case now.}
  \item{api}{the instance of the  \code{\link{TesseractBaseAPI-class}} in which to perform the operations.}
  \item{\dots}{\code{name = value} pairs that are passed to
    \code{SetVariables} to configure the \code{\link{TesseractBaseAPI-class}} instance.}
  \item{init}{a logical value controlling whether \code{Init} is called
    by the \code{tesseract} function.}
  \item{ppi}{the per-pixel resolution as an integer.}
  \item{dims}{a vector of length 4 giving the location of the rectangle
    as x1, y1, x2, y2.}
  \item{files}{a character vector specifying the full or relative paths
    to the configuration files.}
  \item{word}{a character vector of words whose validity we want to
    check}
  \item{name}{the name of the file being processed by the OCR system.}
  \item{lang}{a string specifying the language for the text to be recognized.}
}

\value{

}
\references{
}
\author{
Duncan Temple Lang
}
\seealso{
  \code{\link{GetIterator}}, \code{\link{lapply}}.

  \code{\link{SetVariables}},   \code{\link{PrintVariables}}
}

\examples{
}

\keyword{IO }
\keyword{programming}
