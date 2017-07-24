library(Rtesseract)

f = system.file("images", "Biological_YF_Risk-0_02.png", package = "Rtesseract")
api = tesseract(f)

GetImageDims(api)

 # Get the first two lines - the Transactions ..... and the title of the paper.
SetRectangle(api,  as.integer(c(left = 0, top = 0, width = 4013, height = 400)))
Recognize(api)
w = GetText(api)

# Get the abstract.
SetRectangle(api,  as.integer(c(left = 0, top = 800, width = 4013, height = 870)))
w2 = GetText(api)
