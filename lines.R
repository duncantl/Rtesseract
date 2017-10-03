# .Call("R_leptLines", "inst/images/SMITHBURN_1952_p3.png", "sm_p3.png")
library(Rtesseract)
source("R/leptonica.R")

# Not producing exactly the same as the C code
#
ff = c("pixs.png", "cpixs.png",
    "bin1.png", "cbin1.png",
    "p2.png",   "cpix2.png",
    "p3.png",   "cpix3.png",
    "p4.png",   "cpix4.png",
    "p5.png",   "cpix5.png",
    "p6.png",   "cpix6.png",
    "horLines.png",  "cpix7.png",
    "page3.png" , "sm_p3.png")


p1 = Rtesseract:::pixRead("inst/images/SMITHBURN_1952_p3.png")
p1 = pixConvertTo8(p1)
Rtesseract:::pixWrite(p1, "pixs.png", Rtesseract:::IFF_PNG);# Open("pixs.png")

bin = pixThresholdToBinary(p1, 150)
Rtesseract:::pixWrite(bin, "bin1.png", Rtesseract:::IFF_PNG); #Open("bin1.png")

angle = pixFindSkew(bin)
p2 = pixRotateAMGray(p1, angle[1]*pi/180)
Rtesseract:::pixWrite(p2, "p2.png", Rtesseract:::IFF_PNG); #Open("p2.png")

p3 = pixCloseGray(p2, 51L, 1L)
Rtesseract:::pixWrite(p3, "p3.png", Rtesseract:::IFF_PNG); #Open("p3.png")
p4 = pixErodeGray(p3, 5L, 2L)
Rtesseract:::pixWrite(p4, "p4.png", Rtesseract:::IFF_PNG); #Open("p4.png")

p5 = pixThresholdToValue(p4, 210, 255, p4)
Rtesseract:::pixWrite(p5, "p5.png", Rtesseract:::IFF_PNG); #Open("p5.png")
p6 = pixThresholdToValue(p4, 200, 0, p4)
Rtesseract:::pixWrite(p6, "p6.png", Rtesseract:::IFF_PNG); #Open("p6.png")

bin = pixThresholdToBinary(p6, 210)
Rtesseract:::pixWrite(bin, "horLines.png", Rtesseract:::IFF_PNG); #Open("horLines.png")

pixInvert(p6, p6)
p8 = pixAddGray(p2, p6)

Rtesseract:::pixWrite(p8, "page3.png", Rtesseract:::IFF_PNG); #Open("page3.png")


m = matrix(ff, , 2, byrow = TRUE)
apply(m, 1, function(x) length(unique(file.info(x)$size)) == 1)
