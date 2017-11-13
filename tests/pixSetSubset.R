
library(Rtesseract)

z = pixRead(system.file("images", "sampleImage.jpg", package = "Rtesseract"))

z2 = pixConvertTo8(z)

# top of displayed image
z2[1, ] = 255
stopifnot(all(z2[1,] == 255L))

z2[1:10, ] = 0
stopifnot(all(z2[1:10,] == 0L))

z2[1:10, c(1, 5, 10)] = 128
stopifnot(all(z2[1:10, c(1, 5, 10)] == 128L))

z2[, 1:5] = 127
stopifnot(all(z2[, 1:5] == 127L))

z2[, c(1, 5) + 50] = 127
stopifnot(all(z2[, c(1,5) + 50] == 127L))

w = 1:nrow(z2) > 90
z2[w, ] = 127
stopifnot(all(z2[w, ] == 127L))

wc = 1:ncol(z2) > 90
z2[, wc] = 127
stopifnot(all(z2[, wc] == 127L))

z2[w, wc] = 1
stopifnot(all(z2[w, wc] == 1L))





