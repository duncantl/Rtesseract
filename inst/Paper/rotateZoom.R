library(Rtesseract)
f = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")

px = pixRead(f)
p1 = pixRotate(px, -pi/2)

ts = tesseract(p1)
SetRectangle(ts, dims = c(500, 1000, 3000, 300))
bb = GetBoxes(ts)

