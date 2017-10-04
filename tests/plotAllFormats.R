library(Rtesseract)

# PNG
a <- system.file("images", "OCRSample2.png", package = "Rtesseract")

api1 <- tesseract(a)
plot(api1)

#TIFF

b <- system.file("images", "OCRSample2.tiff", package = "Rtesseract")
if(file.exists(b)) {
   api2 <- tesseract(b)
   plot(api2)
}

# JPEG
c <- system.file("images", "OCRSample2.jpg", package = "Rtesseract")
if(file.exists(c)) {
   api3 <- tesseract(c)
   plot(api3)
}
