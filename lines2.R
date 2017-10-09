showPix =
function(pix, file = tempfile())
{
    pixWrite(pix, file, IFF_PNG)
    Open(file)
}

library(Rtesseract)
f = "inst/images/SMITHBURN_1952_p3.png"
f = "../images/SMITHBURN_1952_p3.png"

p1 = pixRead(f)
p1 = pixConvertTo8(p1)

bin = pixThresholdToBinary(p1, 150)
angle = pixFindSkew(bin)
p2 = pixRotateAMGray(p1, angle[1]*pi/180, 255)

#debug(Rtesseract:::getLines)
# Horizontal lines
h = findLines(p2, 51, 3, TRUE, erode = integer())
m = pixGetPixels(h)
r = rowSums(m)
w = r > 1000
table(w)
diff(which(w))

tess = tesseract(f)
plot(tess)
abline(h = nrow(m) - which(w), col = "red")

if(FALSE) {
    z = apply(m[w,], 1, rle)
    points(1:ncol(m), rep(which(w)[1], ncol(m)), col = c("white", "red")[m[, which(w)[1]] + 1])
}
# Vertical lines

v = findLines(p2, 1, 101, TRUE) # vertical lines
m = pixGetPixels(v)
r = colSums(m)
w = r > 1000
table(w)
diff(which(w))

#tess = tesseract(f)
#plot(tess)
abline(v = which(w), col = "green")



if(FALSE) {
    pixWrite(h, "h.png", IFF_PNG)
    a = png::readPNG("h.png")
    table(a == m)
}
