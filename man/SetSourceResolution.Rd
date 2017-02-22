\name{SetSourceResolution}
\alias{SetSourceResolution}
\alias{GetSourceYResolution}
\title{Set and Get the Pixels Per Inch Resolution for a Tesseract Image}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
SetSourceResolution(api, ppi)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{api}{
%%     ~~Describe \code{api} here~~
}
  \item{ppi}{
%%     ~~Describe \code{ppi} here~~
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
function (api, ppi) 
{
    .Call("R_tesseract_SetSourceResolution", as(api, "TesseractBaseAPI"), 
        as.integer(ppi))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
