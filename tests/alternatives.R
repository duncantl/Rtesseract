library(Rtesseract)
f = system.file("images", "OCRSample2.png", package = "Rtesseract")
api = tesseract(f)
Recognize(api)
alts = getAlternatives(api)

alts1 = getAlternatives(f)
identical(alts, alts1)


if(FALSE) {
 api = tesseract(f)
 Recognize(api)
   # No longer allowing people to get the ResultIterator as it raises memory management coordination
 ri = as(api, "ResultIterator")
 alts3 = getAlternatives(ri)
}




