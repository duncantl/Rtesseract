\name{getAvailableLanguages}
\alias{getAvailableLanguages}
\title{
Obtain a List of Languages Supported by Tesseract Installation
}
\description{
  This function returns a list of all the languages
  the local tesseract installation supports.
  Any of these values can be passed via the \code{lang}
  parameter in the call to \code{\link{tesseract}}
  to specify the language of the content of a document,
  allowing tesseract to use the appropriate alphabet and
  trained model for that language.
  One can install any subset of the available trained languages.
  This  function therefore allows us to programmatically query
  whether a language is supported in this installation of tesseract.
}
\usage{
getAvailableLanguages(api = tesseract())
}
\arguments{
  \item{api}{a Tesseract API object. This can be omitted
  as a default instance will be created.}
}
\details{
  The supported languages are computed via the Tesseract
  API. This looks in the directory identified by the TESSDATA_PREFIX
  environment variable and reports files name \code{<lan>.traineddata}.
}
\value{
A character vector.
}
\references{
  Tesseract \url{https://code.google.com/p/tesseract-ocr/},
  specifically
  \url{http://zdenop.github.io/tesseract-doc/classtesseract_1_1_tess_base_a_p_i.html}  
}
\author{
Duncan Temple Lang
}


\seealso{
\code{\link{tesseract}}
}
\examples{
getAvailableLanguages()
}
\keyword{IO}
\keyword{programming}
