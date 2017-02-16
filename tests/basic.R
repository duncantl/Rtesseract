library(Rtesseract)
f = system.file("images", "OCRSample2.png", package = "Rtesseract")

alts = getAlternatives(f)
w = getConfidences(f)
bb = getBoxes(f)

api = tesseract(f)
Recognize(api)
ri = as(api, "ResultIterator")
alts.ri = getAlternatives(ri)
identical(alts[[1]], alts.ri)
# Why only getting one  letter.

