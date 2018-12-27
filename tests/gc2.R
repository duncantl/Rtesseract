library(Rtesseract)


p = pixRead(f)
rm(p)
gc()



p = pixRead(f)
t = tesseract()
SetImage(p)

