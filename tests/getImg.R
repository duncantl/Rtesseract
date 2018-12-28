library(Rtesseract)
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")

ts = tesseract(f)
a = GetImageInfo(ts)

#if(require(png)) 
#  b = readPNG(f)
       
##ref = GetInputName(ts)

GetImageDims(ts)


