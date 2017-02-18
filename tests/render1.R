library(Rtesseract)
f = "inst/images/OCRSample2.png"
out = Rtesseract:::removeExtension(basename(f))

a = toHTML(f, outFile = out)
b = toOSD(f, out)
c = toTSV(f, outFile = out)
d = toPDF(f, outFile = out)
e = toBoxText(f, out)
f = toUNLV(f, out)

