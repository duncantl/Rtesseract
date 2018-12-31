
library(Rtesseract)
f = system.file("images", "multipage_tiff_example.tif", package = "Rtesseract")

pxs = readMultipageTiff(f)
length(pxs)
#par(mfrow = c(4, 3))

bbs = lapply(pxs, GetBoxes)

