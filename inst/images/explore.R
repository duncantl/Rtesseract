library(Rtesseract)
api = tesseract("1990-10.png")
reg = GetRegions(api)
str = GetStrips(api)

