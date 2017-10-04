\name{pixAnd}
\alias{pixAnd}
\alias{pixOr}
\alias{pixXor}
\alias{pixSubtract}
\title{Logical Operators for pairs of Pix Objects}
\description{
  These functions allow one to perform pixel-wise logical operations on
  pairs of \code{\link{Pix-class}} objects.
}
\usage{
pixAnd(s1, s2, target = NULL)
pixOr(s1, s2, target = NULL)
pixXor(s1, s2, target = NULL)
pixSubtract(s1, s2, target = NULL)
}
\arguments{
  \item{s1,s2}{a \code{\link{Pix-class}} object}
  \item{target}{either a \code{\link{Pix-class}} object or NULL.
          If a \code{Pix} is specified, this is used to store the
	  answer. Otherwise, a new Pix is created and returned.}
}
\value{
  These functions return either a new \code{\link{Pix-class}} object
  or the value of \code{target}.
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
  \code{\link{pixConvertTo8}}
  \code{\link{pixThresholdToValue}}
}
%\examples{}

\keyword{manip}
\concept{image processing}

