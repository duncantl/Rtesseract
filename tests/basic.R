library(Rtesseract)
# The following avoids the 5 warnings messages about the memory leak in ObjectCache::~ObjectCache about the dawgs
.Last = function() gc()
f = system.file("images", "OCRSample2.png", package = "Rtesseract")

alts = GetAlternatives(f)
w = GetConfidences(f)
bb = GetBoxes(f)


if(FALSE) {
     # ResultIterator is no longer part of the end-user functionality.
api = tesseract(f)
Recognize(api)
ri = as(api, "ResultIterator")
alts.ri = GetAlternatives(ri)
identical(alts[[1]], alts.ri)
}


