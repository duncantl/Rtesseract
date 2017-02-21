library(Rtesseract)
f = system.file("images", "OCRSample2.png", package = "Rtesseract")
img = pixRead(f)
o = GetConfidences(img)
head(o)
o1 = GetConfidences(f)
stopifnot(identical(o, o1))


o = GetAlternatives(img)
head(o)
o1 = GetAlternatives(f)
stopifnot(identical(o, o1))

o = GetBoxes(img)
head(o)
o1 = GetBoxes(f)
stopifnot(identical(o, o1))



