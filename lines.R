# .Call("R_leptLines", "inst/images/SMITHBURN_1952_p3.png", "sm_p3.png")
library(Rtesseract)
source("R/leptonica.R")
p1 = Rtesseract:::pixRead("inst/images/SMITHBURN_1952_p3.png")

p2 = pixConvertTo8(p1)

bin = pixThresholdToBinary(p2, 150)
angle = pixFindSkew(bin)

p3 = pixRotateAMGray(p2, angle[1]*pi/180)

p4 = pixCloseGray(p3, 51L, 1L)
p5 = pixErodeGray(p4, 5L, 51L)


p5 = pixThresholdToValue(p5, 210, 255, p5)
p6 = pixThresholdToValue(p5, 200, 0, p5)

bin = pixThresholdToBinary(p6, 210)
Rtesseract:::pixWrite(bin, "horLines.png", Rtesseract:::IFF_PNG)
Open("horLines.png")

pixInvert(p6, p6)
p8 = pixAddGray(p3, p6)

Rtesseract:::pixWrite(p8, "p3.png", Rtesseract:::IFF_PNG)
Open("p3.png")

