library(Rtesseract)
f = system.file("images", "OCRSample2.png", package = "Rtesseract")

out = Rtesseract:::removeExtension(basename(f))

a = toHTML(f, outFile = out)
b = toOSD(f, out)
c = toTSV(f, outFile = out)
d = try(toPDF(f, outFile = out))
e = toBoxText(f, out)
# Not exporting UNLV
#f = toUNLV(f, out)

