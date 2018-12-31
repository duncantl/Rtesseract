\name{pixRead}
\alias{pixRead}
\alias{Pix-class}
\alias{nrow,Pix-method}
\alias{ncol,Pix-method}
\alias{dim,Pix-method}
\alias{[,Pix,logical,logical-method}
\alias{[,Pix,missing,logical-method}
\alias{[,Pix,logical,missing-method}
\alias{[,Pix,numeric,numeric-method}
\alias{[,Pix,missing,numeric-method}
\alias{[,Pix,numeric,missing-method}
\alias{[,Pix,matrix,ANY-method}
\alias{[,Pix,missing,missing-method}
\alias{[<-,Pix,missing,missing-method}
\alias{[<-,Pix,logical,logical-method}
\alias{[<-,Pix,missing,logical-method}
\alias{[<-,Pix,logical,missing-method}
\alias{[<-,Pix,numeric,numeric-method}
\alias{[<-,Pix,missing,numeric-method}
\alias{[<-,Pix,numeric,missing-method}
\alias{[<-,Pix,matrix,missing-method}
\alias{[<-,Pix,missing,missing-method}
\alias{coerce,character,Pix-method}
\alias{plot,Pix-method}
\alias{pixSetDims}
\alias{pixGetDims}
\alias{pixGetDepth}
\alias{pixGetRes}
\alias{pixSetRes}
\alias{pixGetInputFormat}
\alias{pixZero}
\alias{pixEqual}
\alias{pixClone}
\alias{pixCreate}
\alias{pixCreate,numeric-method}
\title{Read an Image for use with Tesseract}
\description{
  This function reads an image, determining what format it is
  and creates a C++ object that can be passed to Tesseract
  for optical character recognition.
}
\usage{
pixRead(filename, addFinalizer = TRUE, multi = FALSE, ...)
pixCreate(x, ...)
}
\arguments{
  \item{filename}{the name of the file, fully or relatively qualified as
    necessary.}
  \item{x}{a vector of length three specifying the width, height and
    depth of the image.}
  \item{addFinalizer}{a logical value that controls whether the C code
      for pixRead adds a finalizer to garbage collect the resulting Pix
      object. When we pass the Pix to tesseract via
      \code{\link{SetImage}}, that tesseract object will attempt to free
      the image when/if it is garbage collected. So we have to avoid two
      attempts to free the same Pix.
    }
  \item{multi}{a logical value. If \code{TRUE} and the file is a TIFF
    file, we read it as a multipage TIFF file. If there are multiple
    images,   we return these as a list.  If not, i.e. there is only one image, we
    return that single image. If \code{FALSE}, we return the first image
    in the file.
  }
  \item{\dots}{additional arguments, currently ignored for
    \code{pixRead} and passed to the methods for \code{pixCreate}.}
}
\value{
  An object of class \code{Pix-class}.
  It is essential that this is assigned to an R variable so that
  it is not garbage collected until the \code{\link{Recognize}}
  function has been called for the \code{\link{TesseractBaseAPI-class}}
  instance.
}
\references{
Leptonica \url{http://leptonica.com/}  
Tesseract \url{https://code.google.com/p/tesseract-ocr/}
}
\author{
Duncan Temple Lang
}
\seealso{
\code{\link{SetImage}}
}
\examples{
 f = system.file("images", "OCRSample2.png", package = "Rtesseract")
 pix = pixRead(f)
 pixGetInputFormat(pix)

 plot(pix)
 dim(pix)
 pix[,]
 
 pixGetInputFormat(pix)
 api = tesseract(pix)
 lapply(api, GetAlternatives, "symbol")
}
\keyword{programming}
\keyword{IO}
