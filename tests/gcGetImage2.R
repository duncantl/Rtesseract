library(Rtesseract)
f = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")
api = tesseract(f)

i = GetImage(api)
gc()
rm(api)
gc()
gc()
# is i still okay?

pixGetDims(i)
# plot(i)
plot(pixInvert(i))


