library(Rtesseract)
f = system.file("images", "OCRSample2.png", package = "Rtesseract")

alts = getAlternatives(f)
w = getConfidences(f)
bb = getBoxes(f)


if(FALSE) {
     # ResultIterator is no longer part of the end-user functionality.
api = tesseract(f)
Recognize(api)
ri = as(api, "ResultIterator")
alts.ri = getAlternatives(ri)
identical(alts[[1]], alts.ri)
}


