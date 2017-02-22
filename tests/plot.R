#
# 
#
#


library(Rtesseract)
library(png)

f = system.file("images", "DifferentFonts.png", package = "Rtesseract")

api = tesseract(f, pageSegMode = 6)
pix = SetImage(api, f)
Recognize(api)

par(mfrow = c(1, 2))
plot(api, main = "Words")
## need to change the level at the API
plot(api, main = "Individual Characters",
     bbox = GetBoxes(api, level = 4))


bbox = GetBoxes(api)
plot(api, NULL, bbox = bbox)


if(FALSE) {

ri = GetIterator(api)
bbox = lapply(ri, BoundingBox, "symbol")

m = do.call(rbind, bbox)
xr = range(m[, 1], m[,3])
yr = range(m[, 2], m[,4])

plot(0, type = "n", xlab = "", ylab = "", xlim = c(0, ncol(img)), ylim = c(0, nrow(img)))


img = readPNG(f)

#rect(0, 0, ncol(img), nrow(img), col = "yellow")

rasterImage(img, 0, 0, ncol(img), nrow(img))


rect(m[,1], nrow(img) - m[,2], m[,3], nrow(img) - m[,4], border = "red")


rect(min(xr), max(yr), max(xr), min(yr), border = "green")
}
