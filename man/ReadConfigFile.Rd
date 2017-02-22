\name{ReadConfigFile}
\alias{ReadConfigFile}
\title{Read a Tesseract Variable Configuration File}
\description{
  This function finds and reads a tesseract configuration
  file that specifies one or more \code{variable value} pairs
  per line.  This can be a convenient way to set multiple
  variables.
}
\usage{
ReadConfigFile(api, files, debug = FALSE, ok = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{api}{an instance of the \code{\link{TesseractBaseAPI-class}}
    obtained from a call to \code{\link{tesseract}}}  
  \item{files}{a character vector giving the names of one or more
    tesseract configuration files. These can be paths to the files
    or alternatively just the names of the files if they are located
    in directories that tesseract searches by default. These are
    the subdirectories  \code{configs/} and \code{tessconfigs/}
    within tesseracts data path which can be queried with \code{\link{GetDatapath}}.
   }
  \item{debug}{if \code{TRUE}, then only process the debug parameter
    settings and not the regular ones.
  }
  \item{ok}{a logical value which controls whether to check if the files
  actually exist}
}
\value{
  This is used for its side-effect of updating the tesseract instance
  with the variable values in the file.
}
\references{
 \url{http://zdenop.github.io/tesseract-doc/classtesseract_1_1_tess_base_a_p_i.html}  
}
\author{
Duncan Temple Lang
}
\seealso{
\code{\link{tesseract}}
}
\examples{
ts = tesseract()
ReadConfigFile(ts, "bigram", ok = TRUE) # read from tessdata/configs

f = system.file("sampleConfigFile", package = "Rtesseract")
GetVariables(ts)["certainty_scale"]
GetVariables(ts)["debug_fix_space_level"]
ReadConfigFile(ts, f, debug = TRUE)
GetVariables(ts)["debug_fix_space_level"]
GetVariables(ts)["certainty_scale"] # unchanged
ReadConfigFile(ts, f)
GetVariables(ts)["certainty_scale"] # changed
}
\keyword{IO}
\keyword{programming}

