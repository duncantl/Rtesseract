library(Rtesseract)

api = tesseract()
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
pix = SetImage(api, f)

Recognize(api)
ri = GetIterator(api)
bbox = lapply(ri, BoundingBox, 3L)

m = do.call(rbind, bbox)
xr = range(m[, 1] + m[,3])
yr = range(m[, 2] + m[,4])

plot(0, type = "n", xlab = "", ylab = "", xlim = c(0, max(xr)), ylim = c(0, max(yr)))

library(png)
img = readPNG(f)
rasterImage(img, 0, 0, max(xr), max(yr))

rect(m[,1], max(yr) - m[,2], m[,3], max(yr) - m[,4], border = "red")

rect(min(xr), max(yr), max(xr), min(yr), border = "green")
