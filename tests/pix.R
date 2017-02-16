library(Rtesseract)
f = system.file("images", "OCRSample2.png", package = "Rtesseract")
img = pixRead(f)
o = getConfidences(img)
head(o)
o1 = getConfidences(f)
stopifnot(identical(o, o1))


o = getAlternatives(img)
head(o)
o1 = getAlternatives(f)
stopifnot(identical(o, o1))

o = getBoxes(img)
head(o)
o1 = getBoxes(f)
stopifnot(identical(o, o1))



