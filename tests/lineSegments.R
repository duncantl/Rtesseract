library(Rtesseract);
smithburn = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")

pp = pixRead(smithburn)
h = getLines(pp, 101, 5)
plot(pp)
lines(h, nrow(pp))


# Note 51 for length is too small - many false positives.
v = getLines(pp, 5, 101)
lines(v, nrow(pp), col = "blue")
