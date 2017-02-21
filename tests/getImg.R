library(Rtesseract)
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")

ts = tesseract(f)
a = GetImageInfo(ts)

library(png)
b = readPNG(f)
       
##ref = GetInputName(ts)

GetImageDims(ts)


