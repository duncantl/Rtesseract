library(Rtesseract)
f = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")

px = pixRead(f)
px = pixConvertTo8(px)
p1 = pixRotateAMGray(px, -pi/2)
plot(p1)


ts = tesseract(p1)
#XXX This gives nonsensical values for 
SetRectangle(ts, dims = c(500, 4900, 3000, 100))
bb = GetBoxes(ts)
#  left    bottom right        top text confidence
# 1    1 226341968 32714 1963090656               0

ts = tesseract(p1)
SetRectangle(ts, dims = c(500, 1000, 3000, 300))
bb = GetBoxes(ts)


ts = tesseract(f)
plot(ts)
SetRectangle(ts, dims = c(500, 4800, 3000, 1000))
bb = GetBoxes(ts)

SetRectangle(ts, dims = c(500, 500, 3000, 1400))
bb = GetBoxes(ts)
