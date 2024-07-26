\name{GetFontInfo}
\alias{GetFontInfo}
\alias{GetFontInfo,Pix-method}
\alias{GetFontInfo,TesseractBaseAPI-method}
\alias{GetFontInfo,character-method}
\title{Get the font information from the tesseract instance}
\description{
  This gets font information from an OCR document.
}
\usage{
GetFontInfo(obj, level = 3L, ...)
}
\arguments{
  \item{obj}{a tesseract, Pix, or file path name of a scanned document}
  \item{level}{process the elements at the character, word, line, block level}
  \item{\dots}{additional arguments for the methods}
}
\value{}
%\references{}
\author{
  Duncan Temple Lang
}
%\seealso{}
%\examples{}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
