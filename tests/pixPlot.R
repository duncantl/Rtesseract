library(Rtesseract)

f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
pix = pixRead(f)
pix1 = pixConvertTo8(pix)
Rtesseract:::plot.Pix(pix1)


