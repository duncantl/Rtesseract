library(Rtesseract)
# f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
f = system.file("images", "OCRSample2.png", package = "Rtesseract")
p = pixRead(f)
z = pixGetRGBPixels(p)
class(z)
dim(z)
range(z)

