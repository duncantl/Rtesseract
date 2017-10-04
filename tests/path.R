library(Rtesseract)

api = tesseract()

f = system.file("images", "OCRSample2.png", package = "Rtesseract")
pix = pixRead(f)
SetImage(api, pix)

GetInputName(api) # NA

GetDatapath(api) 

