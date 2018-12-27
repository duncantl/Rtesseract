library(Rtesseract)

f = system.file("images", "OCRSample2.png", package = "Rtesseract")
pix = pixRead(f)

.Call("R_pixGetRefcount", pix)
pix2 = .Call("R_pixCopy", pix)
.Call("R_pixGetRefcount", pix2)

rm(pix)
gc()
gc()

.Call("R_pixGetRefcount", pix2)
dim(pix2)
rm(pix2)
gc()





