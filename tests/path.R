library(Rtesseract)

api = tesseract()

f = system.file("images", "OCRSample.tiff", package = "Rtesseract")
pix = pixRead(f)
SetImage(api, pix)

GetInputName(api) # NA

GetDatapath(api) 

