library(Rtesseract)

f = system.file("images", "1990_p44.png", package = "Rtesseract")
api = tesseract(f)

conf = getConfidences(api)

plot(api)

grep("3560", names(conf))

 # Zoom in on the table at the bottom of the image.
 # Note that the 320 and 100 are width and height, not right and top
SetRectangle(api, 10, 117, 320, 100)

Recognize(api)
conf1 = getConfidences(api)

plot(api)

