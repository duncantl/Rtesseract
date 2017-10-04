library(Rtesseract)

f = system.file("images", "OCRSample2.png", package = "Rtesseract")
api = tesseract()
pix = pixRead(f)
SetImage(api, pix)
SetInputName(api, f)

conf = GetConfidences(api)

 # Zoom in on the table at the bottom of the image.
 # Note that the 320 and 100 are width and height, not right and top
SetRectangle(api, 10, 117, 320, 100)

Recognize(api)
conf1 = GetConfidences(api)

#plot(api)

if(FALSE) {
ri = GetIterator(api)
conf1 = lapply(ri, Confidence, 3L)
}
