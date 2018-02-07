library(Rtesseract)

f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
pix = pixRead(f)

p1 = pixFlipTB(pix)
plot(pix)
plot(p1)

p2 = pixFlipLR(pix)
plot(p2)

# Flipped in both  ways - top-bottom and left-right.
p3 = pixFlipLR(p1)
plot(p3)
