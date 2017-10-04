
library(Rtesseract)
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
pix = pixRead(f)
pixGetInputFormat(pix)

f = system.file("images", "DifferentFonts.tiff", package = "Rtesseract")
pix = pixRead(f)
pixGetInputFormat(pix)

