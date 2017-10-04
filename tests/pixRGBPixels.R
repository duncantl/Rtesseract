library(Rtesseract)
p = pixRead("inst/images/DifferentFonts.png")
z = pixGetRGBPixels(p)
class(z)
dim(z)
range(z)

