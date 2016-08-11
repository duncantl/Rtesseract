# experiment with our own renderer

library(Rtesseract)
f = system.file("images", "OCRSample.png", package = "Rtesseract")
ts = tesseract(f)
o = .Call("R_Tesseract_RenderBoxes", ts)

