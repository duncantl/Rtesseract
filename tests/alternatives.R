library(Rtesseract)
f = system.file("images", "OCRSample2.png", package = "Rtesseract")

alts = ocr(f, alternatives = TRUE)

alts1 = getAlternatives(f)
identical(alts, alts1)


api = tesseract(f)
Recognize(api)
alts2 = getAlternatives(api)

api = tesseract(f)
Recognize(api)
ri = as(api, "ResultIterator")
alts3 = getAlternatives(api)



