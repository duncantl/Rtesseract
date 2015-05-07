library(Rtesseract)

api = tesseract()
Init(api)

f = system.file("images", "OCRSample.tiff", package = "Rtesseract")
pix = pixRead(f)
SetImage(api, pix)
Recognize(api)
ri = GetIterator(api)

sym = getNativeSymbolInfo("r_getConfidence")
conf = lapply(ri, sym$address, 3L)

conf1 = lapply(ri, Confidence, 3L)

bbox = lapply(ri, BoundingBox, 3L)



