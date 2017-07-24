library(Rtesseract)

f = system.file("images", "Biological_YF_Risk-0_02.png", package = "Rtesseract")
api = tesseract(f)

d = GetImageDims(api)
p = Rtesseract:::GetImage(api)
GetImageDims(p)
