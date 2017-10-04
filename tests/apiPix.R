library(Rtesseract)

f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
pix = pixRead(f)
tess = tesseract(pix)
bb = GetBoxes(tess)
nrow(bb)



