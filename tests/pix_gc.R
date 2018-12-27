library(Rtesseract)

f = system.file("images/1990-10.png", package = "Rtesseract")
i = pixRead(f)
rm(i)
gc()



