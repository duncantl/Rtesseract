\name{ReadConfigFile}
\alias{ReadConfigFile}
\title{Read a Tesseract Variable Configuration File}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
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
\details{
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (api, files, debug = FALSE, ok = FALSE) 
{
    ff = path.expand(files)
    if (!ok && !all(ok <- file.exists(ff))) 
        stop("some files don't exist: ", paste(ff[!ok], collapse = ", "))
    .Call("R_tesseract_ReadConfigFile", as(api, "TesseractBaseAPI"), 
        ff, as.logical(debug))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
