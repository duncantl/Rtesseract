library(Rtesseract)
# PNG
a <- system.file("images", "OCRSample2.png", package = "Rtesseract")

api1 <- tesseract(a)
plot(api1)

#TIFF
b <- system.file("images", "OCRSample2.tiff", package = "Rtesseract")

api2 <- tesseract(b)
plot(api2)

# JPEG
c <- system.file("images", "OCRSample2.jpg", package = "Rtesseract")

api3 <- tesseract(c)
plot(api3)
