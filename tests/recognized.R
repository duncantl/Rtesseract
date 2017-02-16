library(Rtesseract)
f = system.file("images", "OCRSample2.png", package = "Rtesseract")

a = tesseract(f)
hasRecognized(a) # FALSE
Recognize(a)
hasRecognized(a) # TRUE
