library(Rtesseract)

api = tesseract()
#Init(api)
f = system.file("images", "OCRSample.tiff", package = "Rtesseract")
pix = pixRead(f)
SetImage(api, pix)

 # Zoom in on the table at the bottom of the image.
SetRectangle(api, 10, 117, 320, 100)

Recognize(api)
ri = GetIterator(api)

conf1 = lapply(ri, Confidence, 3L)
