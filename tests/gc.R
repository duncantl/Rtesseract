library(Rtesseract)
smithburn = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")
api = tesseract(smithburn)
# Calling Recognize() and not GetBoxes() doesn't cause a seg fault.
#  Recognize(api)
# It is the call to GetBoxes() that trip the seg fault and specifically
# it is the call get GetImage() near the end when we add the dimensions
# of the image to the results. 
tmp2 = GetBoxes(api)
gc()
rm(api)
#api = tesseract(smithburn)
gc()
