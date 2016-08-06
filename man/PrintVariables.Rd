\name{PrintVariables}
\alias{PrintVariables}
\alias{GetVariables}
\alias{SetVariables}
\title{Query or Set Tesseract Variables}
\description{
  These functions allow us to query all or some of the
  tesseract variables controlling the OCR behavior.
  We can also set these variables from within R.
}
\usage{
GetVariables(api, var)
PrintVariables(api = tesseract(), asDataFrame = FALSE, file = tempfile())
SetVariables(api, ..., opts = list(...))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{api}{an instance of the \code{\link{TesseractBaseAPI-class}},
    created via a call to \code{\link{tesseract}}}
  \item{var}{a character vector specifying the names of the variables to
    be queried.  If this is omitted, \code{GetVariables} returns all of
    the tesseract variables.}
  \item{file}{the name of a file to which the variable name and values
    are written. If this is omitted, \code{PrintVariables} returns the
    list of variable values, just like \code{GetVariables}.}
  \item{\dots}{\code{name = value} pairs specifying the name of the
    variable and its new value to be set in the tesseract object.
  }
  \item{opts}{an alternative way to specify the \code{name = value}
    pairs of variable name and values to set. This allows the caller to
    compute the variable names and values and pass the resulting list or
    vector as a single argument rather than as individual arguments in
    the call.
  }
  \item{asDataFrame}{a logical value. If \code{TRUE}, the options, their
  values and information describing the purpose of the option are
  returned as 3-column data frame. If this is \code{FALSE},
  a named character vector  is returned giving the option value and the
  associated name.  No description of the options is returned.
 }
}
\value{
  \code{GetVariables} returns a named list containing the values for the different tesseract
  variables.
  The names are the variable names.
  This is a list rather than a vector since the tesseract variables
  can be strings, logical/boolean values, or numbers - either integer or
  real valued.

  \code{PrintVariables} called without a value for \code{file}
  returns a named character vector. The type of each variable
  is lost.
}
\references{
Tesseract \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{tesseract}},
  \code{\link{TesseractBaseAPI-class}}  
}
\examples{
  api = tesseract()
  v = GetVariables(api)
  head(names(v))
  table(sapply(v, class)) 

  out = tempfile()
  PrintVariables(api, file = out)
}
\keyword{programming}

