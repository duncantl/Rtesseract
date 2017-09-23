library(Rtesseract)
a = tesseract(datapath = "~/Projects/OCR/")
GetDatapath(a)
a = tesseract(datapath = "../")
GetDatapath(a)
a = tesseract(datapath = "..")
GetDatapath(a)

