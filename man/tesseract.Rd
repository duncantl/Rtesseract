\name{tesseract}
\alias{tesseract}
\alias{TesseractBaseAPI-class}
\alias{Recognize}
\alias{Init}

\title{Creating a Tesseract Object}
\description{
  The \code{ocr} function hides all of the details of the OCR mechanism.
  The \code{tesseract} function provides an entry to much more control
  and detail about the process and the ability to query the results in
  different ways. The \code{tesseract} function is the building
  block for \code{\link{ocr}} and all the functionality of the package.
  
  To perform OCR on an image, we need a Tesseract API object
  and then can call its methods.
  We create such an object with the \code{tesseract} function.
  We typically specify the image, the segmentation mode for identifying the
  elements in the page, and also the language for the content.
  We can also set any of the over 600 variables that control  how
  tesseract operates on the image. (See \code{\link{PrintVariables}}.)

  We can create a tesseract object without specifying an image, the
  segmentation mode, etc.
  Instead, we can set this later when we use the tesseract object,
  and we can also update these values to reuse the same tesseract
  object on different images, with different segmentation modes, etc.
  Alternatively, we can create new separate tesseract objects
  that work on different images or in different segmentation modes.

  The \code{tesseract} function, by default, performs the initialization
  of the internal C++ object. This can be deferred if necessary (with
  \code{init = FALSE}. Also, a tesseract object can be re-initialized.

  One has to be careful when initializing a tesseract object because
  it will reset the page segmentation  mode to a default value.
  So it is vital to set that after initialization. The \code{tesseract}
  function takes care of this.

  We can set tesseract variables at any point in the lifetime of the
  tesseract object, either in the call to \code{tesseract},
  \code{Init} or \code{\link{SetVariables}}.
  However, there are some variables that need to be explicitly set in
  the call to \code{Init} or before.

  There are many functions that operate on a \code{TesseractBaseAPI}
  object that provide the interesting functionality for the package.
  These are noted in the see also section and in other help pages,
  e.g., \code{\link{GetDatapath}}, \code{\link{GetVariables}}, \code{\link{SetVariables}}.

  When we have configured the tesseract object appropriately,
  we call \code{\link{Recognize}} to perform the OCR.
  We then collect the results in which we are interested.

  We can extract the bounding boxes of the elements it recognizes.
  We can get the confidence associated with each match it made.
  We can obtain the alternatives or "next best" guesses the OCR had for
  each element.
  
  We can switch the image to be processed, the page segmentation mode,
  quey the file name of the current image, get the image itself,
  query the current variable settings for tesseract,
  ask if a particular word is considered valid.

  We can also zoom in to a sub-region of the image and run the OCR again
  on this part.

  We can query the current state and settings of the tesseract object.

  The package also provides a way to plot a tesseract object,
  i.e., show the image and superimpose the bounding boxes of the recognized
  elements in the image.
  One can color the rectangles by their confidence/accuracy levels.
  In the future, we may develop an interactive plot to allow users to
  visually explore  and compare the original image and the OCR text.

  We can also treat the \code{TesseractBaseAPI} as a virtual list
  and then use \code{lapply} to iterate over its elements.
  There are functions within the package that
  can be used within the \code{lapply} to extract the
  individual elements of the results.
  These are \code{BoundingBox}, \code{GetAlternatives}, ...
  There are equivalent higher-level functions to  access these elements
   more efficiently, but with less flexibility.
}
\usage{
tesseract(image = character(), pageSegMode = integer(), lang = "eng",
          datapath = NA, configs = character(), vars = character(),
          engineMode = OEM_DEFAULT, debugOnly = FALSE,
          ..., opts = list(...), init = TRUE)


Init(api, lang = "eng", configs = character(), vars =
     character(), datapath = NA, engineMode = OEM_DEFAULT,
     debugOnly = FALSE, force2 = FALSE)

Recognize(api)
}
\arguments{
  \item{image}{either a \code{\link{Pix-class}} object, or a file name
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
  \item{pageSegMode}{the value for the page segmentation mode for the tesseract
  instance. This must correspond to one of the values in
  \code{PageSegModeValues} or the corresponding R variables.
   However, one can use symbolic names (lower or upper case) from this
   vector, e.g., \code{"psm_auto"}.
 }  
 \item{force2}{a logical value to control whether to use the Init2
   routine. Should never be needed.}  
}

\value{
  The \code{tesseract} function returns an object of class
  \code{TesseractBaseAPI}.  This is an S4 object that contains
  an opaque  reference to a C++ object. It should be used in other calls
  expecting the tesseract instance.

  For \code{tesseract}, if the file format of the image is not supported
  by the installed leptonica library being used, an error of class \code{UnsupportedImageFormat} is raised.
  The error message indicates the supported image types, and the
  error object also contains the name of the file in the \code{filename}
  element.    

  \code{Init} returns a logical value indicating whether the
  initialization was successful \code{TRUE}, or raises
  an error of class \code{TesseractInitFailure}.
  This provides an opportunity to catch the error and use a different
  initialization approach (e.g. different language, variables, engine
  mode).

  \code{Recognize} returns \code{TRUE} if the call was successful.
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
  \code{\link{SetVariables}},   \code{\link{PrintVariables}},
  \code{\link{SetInputName}},  \code{\link{SetImage}},
  \code{\link{SetOutpuName}},
  \code{\link{ReadConfigFile}},
  \code{\link{SetVariables}}, \code{\link{GetVariables}},
  \code{\link{PrintVariables}},
  \code{\link{SetPageSegMode}},     \code{\link{GetPageSegMode}},
  \code{\link{SetRectangle}},
  \code{\link{SetSourceResolution}},   \code{\link{SetSourceYResolution}},   
  \code{\link{ProcessPages}}  
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

\keyword{IO}
\keyword{programming}
