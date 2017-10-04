library(Rtesseract)

f = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")
pix = pixRead(f)
plot(pix)
plot(pix, rgb = FALSE)


