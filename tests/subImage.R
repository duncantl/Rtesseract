library(Rtesseract)

f = system.file("images/OCRSample2.png", package = "Rtesseract")
img = png::readPNG(f)
bb = GetBoxes(f)
plotSubImage(bb[1:4, ], img)


