library(Rtesseract)

f = system.file("images", "min.png", package = "Rtesseract")
pix = pixRead(f)
pix = pixConvertTo8(pix)

tr = pixGetPixels(pix)
attr(tr, "dim") = unname(attr(tr, "dim"))
z = pix[1:20, 1:20]
all(tr == z)

all.equal(tr[1:20,], pix[1:20,])

all.equal(tr[, 1:20], pix[, 1:20])

all.equal(tr[rep(c(TRUE, FALSE), 10), ], pix[rep(c(TRUE, FALSE), 10), ])
all.equal(tr[, rep(c(TRUE, FALSE), 10)], pix[, rep(c(TRUE, FALSE), 10)])

#################
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
pix = pixRead(f)
pix = pixConvertTo8(pix)
tr = pixGetPixels(pix)
z = pix[,]
all(tr == z)


i = sample(1:nrow(pix), 10)
j = sample(1:ncol(pix), 11)
tr = pixGetPixels(pix)[i, j]
z = pix[i, j]
all(tr == z)



########
# Faster if getting a small subset of the matrix. (12 - 40 times faster)
# Still faster even if getting large portions.

system.time(replicate(200, pix[i, j]))
system.time(replicate(200, pixGetPixels(pix)[i, j]))

r = nrow(pix)
c = ncol(pix)
system.time(replicate(200, pix[1:r, 1:c]))
system.time(replicate(200, pixGetPixels(pix)[1:r, 1:c]))


