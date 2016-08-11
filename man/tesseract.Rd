\name{tesseract}
\alias{tesseract}
\alias{TesseractBaseAPI-class}
\alias{SetImage}
\alias{GetImage}
\alias{GetInputImage}
\alias{Recognize}
\alias{SetRectangle}
\alias{SetSourceResolution}
\alias{GetInputName}
\alias{SetInputName}
\alias{GetDatapath}
\alias{GetInitLanguages}
\alias{ReadConfigFile}
\alias{GetSourceYResolution}
\alias{IsValidWord}
\alias{Init}
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

\title{Top-level Tesseract OCR API Functions and Classes}
\description{
  To perform OCR on an image, we need a Tesseract API object
  and then can call its methods.
  We create such an object with the \code{tesseract} function.
  We can specify the image,  segmentation mode for identifying the
  elements, and also the language for the content.
  We can also set any of the over 600 variables that control  how
  tesseract operates on the image. (See \code{\link{PrintVariables}}.)

  The \code{\link{ocr}} function is a function that does the OCR and
  hides the  tesseract API object.  However, working with the
  tesseract object gives us more control and allows us to query the
  results in different ways.

  We can zoom in to a part of the image.
  
  
  If the file format of the image is not supported by the leptonica library being
  used, an error of class \code{UnsupportedImageFormat} is raised.
  The error message indicates the supported image types, and the
  error object also contains the name of the file in the \code{filename} element.
}
\usage{
tesseract(image = character(), pageSegMode = integer(), lang = "eng",
          datapath = NA, configs = character(), vars = character(),
          engineMode = OEM_DEFAULT, debugOnly = FALSE,
          ..., opts = list(...), init = TRUE)

SetImage(api, pix)
Init(api, lang = "eng", configs = character(), vars =
     character(), datapath = NA, engineMode = OEM_DEFAULT,
     debugOnly = FALSE, force2 = FALSE)

SetRectangle(api, ..., dims = sapply(list(...), as.integer))
SetSourceResolution(api, ppi)
Recognize(api)

SetInputName(api, name, check = TRUE, load = TRUE)
GetInputName(api)
GetDatapath(api)
GetInitLanguages(api)
ReadConfigFile(api, files, ok = FALSE)
GetSourceYResolution(api)

GetPageSegMode(api)
SetPageSegMode(api, mode)

IsValidWord(api, word)

SetOutputName(api, filename)
oem(api)

hasRecognized(api)

GetThresholdedImage(api)

Clear(api)
ClearAdaptiveClassifier(api)
End(api)
}
\arguments{
  \item{image,pix}{either a \code{\link{Pix-class}} object, or a file name
    from which to read the image. Specifying the name of a file also
    arranges to call \code{\link{SetInputName}} and so the
    \code{\link{TesseractBaseAPI-class}}
    instance knows where the image is located. This means we can query
    it.
    If speciyfing the name of a file, make certain to assign the result
    to a variable that persists until \code{Recognize} is called for
    this \code{\link{TesseractBaseAPI-class}} instance.
    In the future, we will ensure that garbage collection protects the
    image, but it is not the case now.}
  \item{api}{the instance of the  \code{\link{TesseractBaseAPI-class}}
    in which to perform the operations.}
  \item{lang}{a string identifying the language(s) for the character
    recognition}
  \item{datapath}{the name of a directory that contains the tessdata/
    directory.}
  \item{engineMode}{the mode for the OCR engine. The default is to use
    tesseract. One can use a Cube method, or a Cube and Tesseract
    combinatin. See the \code{OcrEngineMode} enumerated constant vector.}
  \item{configs}{a named character vector of configuration arguments}
  \item{vars}{variables to set for controling Tesseract}
  \item{debugOnly}{a logical value that controls whether in the Init()
    call, only non-debugging variables in \code{vars} are to be processed.}
  \item{\dots}{\code{name = value} pairs that are passed to
    \code{SetVariables} to configure the
    \code{\link{TesseractBaseAPI-class}} instance.}
  \item{opts}{a list (or vector) of named values that are the options
    we can pass via \code{\dots}.}
  \item{init}{a logical value controlling whether \code{Init} is called
    by the \code{tesseract} function.}
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

\value{
The different functions return very different objects.
}
\references{
  Tesseract \url{https://code.google.com/p/tesseract-ocr/},
  specifically
  \url{http://zdenop.github.io/tesseract-doc/classtesseract_1_1_tess_base_a_p_i.html}
}
\author{
Duncan Temple Lang
}
\seealso{
  \code{\link{GetIterator}}, \code{\link{lapply}}.

  \code{\link{SetVariables}},   \code{\link{PrintVariables}}
}

\examples{
 f = system.file("images", "OCRSample2.png", package = "Rtesseract")
 api = tesseract(f)
 GetInputName(api)
 Recognize(api)
 ri = GetIterator(api)
 bbox = lapply(ri, BoundingBox, "word")

 if(require("png")) {
    i = readPNG(f)
    plot(api, level = "symbol", img = i, border = "red")
 }
}

\keyword{IO }
\keyword{programming}
