\name{pixAddGray}
\alias{pixAddGray}
\alias{pixInvert}
\alias{pixErodeGray}
\alias{pixCloseGray}
\alias{pixConvertTo8}
\title{Pix Operations}
\description{
  This is one collection of functions useful for manipulating
  \code{\link{Pix-class}} objects.
}
\usage{
pixAddGray(pix1, pix2, target = NULL)
pixInvert(pix, target = NULL)
pixCloseGray(pix, horiz, vert)
pixErodeGray(pix, horiz, vert)
pixConvertTo8(pix, colormap = FALSE)
}
\arguments{
  \item{pix,pix1,pix2}{a \code{\link{Pix-class}} object}
  \item{target}{either a \code{\link{Pix-class}} object or NULL.
          If a \code{Pix} is specified, this is used to store the
	  answer. Otherwise, a new Pix is created and returned.}
  \item{colormap}{a logical value indicating whether to include or
    exclude the color map for the new image.
  }
  \item{horiz}{the width in pixels of the horizontal region for the
    operation}
  \item{vert}{the width in pixels of the vertical region for the operation}  
 }
 \value{
   These functions return a \code{\link{Pix-class}} object.
 }

\references{
  \url{http://tpgit.github.io/UnOfficialLeptDocs/}
} 
\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{pixRead}}
  \code{\link{GetInputImage}}
  \code{\link{pixAnd}}  
}
\examples{
}
\keyword{manip}
\concept{image processing}
