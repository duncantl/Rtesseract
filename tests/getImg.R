library(Rtesseract)
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")

ts = tesseract(f)
a = GetInputImage(ts)

library(png)
b = readPNG(f)
       

ref = GetInputImage(ts, FALSE)

getImageDims(ref)


