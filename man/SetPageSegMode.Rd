\name{SetPageSegMode}
\alias{SetPageSegMode}
\alias{GetPageSegMode}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Set and Query the Page Segmentation Mode for Tesseract Instance}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
SetPageSegMode(api, mode)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{api}{
%%     ~~Describe \code{api} here~~
}
  \item{mode}{
%%     ~~Describe \code{mode} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
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
function (api, mode) 
{
    .Call("R_TessBaseAPI_SetPageSegMode", as(api, "TesseractBaseAPI"), 
        as(mode, "PageSegMode"))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
