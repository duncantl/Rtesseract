\name{tesseractFuns}
\alias{tesseractFunctions}
%\alias{SetImage}
%\alias{GetImage}
%\alias{GetInputImage}
%\alias{GetInputName}
%\alias{SetInputName}

%\alias{SetRectangle}
%\alias{SetSourceResolution}
%\alias{GetSourceYResolution}

%\alias{ReadConfigFile}

%\alias{GetPageSegMode}
%\alias{SetPageSegMode}
%\alias{SetOutputName}

%\alias{ProcessPages}
%\alias{SetVariables}

\alias{coerce,TesseractBaseAPI,ResultIterator-method}

\title{Set and Query the Tesseract Object}
\description{
  These functions provide ways to both set and query the state of the
  tesseract object.
  
}
\usage{
ReadConfigFile(api, files, debug = FALSE, ok = FALSE)
SetImage(api, pix)
SetInputName(api, name, check = TRUE, load = TRUE)
GetInputName(api)
GetImage(api, asArray = FALSE)

SetPageSegMode(api, mode)
GetPageSegMode(api)

SetRectangle(api, ..., dims = sapply(list(...), as.integer))

SetSourceResolution(api, ppi)
GetSourceYResolution(api)

SetOutputName(api, filename)

ProcessPages(filename, api = tesseract(), timeout = 0L, out = tempfile())
}
\arguments{
  \item{api}{the instance of the  \code{\link{TesseractBaseAPI-class}}
    in which to perform the operations.}
  \item{pix}{an object of class \code{Pix} from \code{\link{pixRead}}.}  
  \item{asArray}{ a logical value. If \code{FALSE},
    the image is returned as a reference to the internal C++
    object. If \code{TRUE}, the contents of the C++ image are returned
    as a 3-dimensional array.
  }
  \item{ppi}{the per-pixel resolution as an integer.}
  \item{dims}{a vector of length 4 giving the location of the rectangle
    as x1, y1, width, height.  This should NOT be the coordinates
    of the top-left and bottom-right of the rectangle, i.e. \code{(x1, y1, x2, y2)}.
    The 3rd and 4th values are the width and height of the box.}
  \item{\dots}{the left, top, width and height}
  \item{files}{a character vector specifying the full or relative paths
    to the configuration files.}
  \item{name}{the name of the file being processed by the OCR system.}
  \item{ok}{in \code{ReadConfigFile}, tesseract can locate configuration
    files in its data directory (typically, /usr/local/share/tessdata or
    specified with the environment variable \code{TESSDATA})}
  \item{mode}{the value for the page segmentation mode for the tesseract
  instance. This must correspond to one of the values in
  \code{PageSegModeValues} or the corresponding R variables.
   However, one can use symbolic names (lower or upper case) from this
   vector, e.g., \code{"psm_auto"}.
 }
 \item{check}{check to see if the file actually exists}
 \item{load}{load the image in the file name and set it as the current
   image in the tesseract object.}
 \item{filename,out}{the name of the file.
   This is the name of the image file to process, or the output
   file to which the results of the OCR will be directed, if that
   occurs.  The latter is rarely of interest as we can
   get this information directly from the \code{TesseractBaseAPI}
   object directly.
 }
 \item{timeout}{this is almost always 0 and so not specified.
 It controls how long any particular step in the processing should be
   allow to take before terminating the entire process.}
}

\author{
  Duncan Temple Lang
}
\seealso{
\code{\link{tesseract}}
}
\keyword{IO }
\keyword{programming}
