
library(Rtesseract)

f = tempfile()
try({
png(f, 300, 300); plot(0, type ='n', axes = FALSE, xlab = "", ylab = ""); dev.off()
pix = pixRead(f)
r1 = range(pixGetPixels(pix))
pixZero(pix)
})


