library(Rtesseract)

f = system.file("images/OCRSample2.png", package = "Rtesseract")
bb = GetBoxes(f)

img = png::readPNG(f)
plotSubImage(bb[1:4, ], img)

#img = png::readPNG(f)
pix = pixRead(f)
plotSubImage(bb[1:4, ], pix)



