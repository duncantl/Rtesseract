library(Rtesseract)

f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
pix = pixRead(f)
tess = tesseract(pix)
plot(tess, img = pix)



