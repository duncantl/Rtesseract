library(Rtesseract)

f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
pix = pixRead(f)
dim(pix)
nrow(pix)
ncol(pix)

