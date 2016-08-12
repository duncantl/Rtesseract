\name{tesseractFuns}
\alias{SetImage}
\alias{GetImage}
\alias{GetInputImage}
\alias{SetRectangle}
\alias{SetSourceResolution}
\alias{GetInputName}
\alias{SetInputName}
\alias{GetDatapath}
\alias{GetInitLanguages}
\alias{ReadConfigFile}
\alias{GetSourceYResolution}
\alias{IsValidWord}
\alias{End}
\alias{Clear}
\alias{plot,TesseractBaseAPI-method}
\alias{coerce,TesseractBaseAPI,ResultIterator-method}
\alias{GetPageSegMode}
\alias{SetPageSegMode}
\alias{ClearAdaptiveClassifier}
\alias{GetThresholdedImage}
\alias{SetOutputName}
\alias{hasRecognized}
\alias{oem}
%\alias{SetVariables}

\usage{
SetImage(api, pix)
SetInputName(api, name, check = TRUE, load = TRUE)
GetInputName(api)

GetPageSegMode(api)
SetPageSegMode(api, mode)

SetRectangle(api, ..., dims = sapply(list(...), as.integer))

SetSourceResolution(api, ppi)
GetSourceYResolution(api)

ReadConfigFile(api, files, ok = FALSE)

IsValidWord(api, word)

SetOutputName(api, filename)

GetThresholdedImage(api)
}
\arguments{
  \item{api}{the instance of the  \code{\link{TesseractBaseAPI-class}}
    in which to perform the operations.}
  \item{pix}{}
  \item{ppi}{the per-pixel resolution as an integer.}
  \item{dims}{a vector of length 4 giving the location of the rectangle
    as x1, y1, x2, y2.}
  \item{files}{a character vector specifying the full or relative paths
    to the configuration files.}
  \item{word}{a character vector of words whose validity we want to
    check}
  \item{name}{the name of the file being processed by the OCR system.}
  \item{ok}{in \code{ReadConfigFile}, tesseract can locate configuration
    files in its data directory (typically, /usr/local/share/tessdata or
    specified with the environment variable \code{TESSDATA})}
  \item{mode,pageSegMode}{the value for the page segmentation mode for the tesseract
  instance. This must correspond to one of the values in
  \code{PageSegModeValues} or the corresponding R variables.
   However, one can use symbolic names (lower or upper case) from this
   vector, e.g., \code{"psm_auto"}.
 }
 \item{check}{check to see if the file actually exists}
 \item{load}{load the image in the file name and set it as the current
   image in the tesseract object.}
 \item{force2}{a logical value to control whether to use the Init2
   routine. Should never be needed.}
}