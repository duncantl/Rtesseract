library(Rtesseract)
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")

ts = tesseract(f)
plot(ts, img = NULL)


# Now with the image.
if(require(png))
  plot(ts)    


