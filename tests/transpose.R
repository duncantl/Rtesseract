library(Rtesseract)
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
p1 = pixRead(f)

m = p1[,]
d = GetImageDims(p1)
p2 = pixCreate(d[c(2, 1, 3)])
#plot(p2)
m0 = p2[,]
GetImageDims(p2)
X = t(m)
#X = X[nrow(X):1,]
X = X[, ncol(X):1]
.Call("R_pixSetAllPixels", p2, rev(dim(m)), X)
m2 = p2[,]
#p2[,] = t(m)

plot(p1)
plot(p2)
