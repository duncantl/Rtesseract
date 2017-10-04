png("minPNG.png", 20, 20, bg = "transparent", pointsize = 1)
par(mar = rep(0, 4)); plot(1:20, type = "n", axes = FALSE, xaxs = "i", yaxs = "i");
#box(col = "green");
rect(1, 5, 9, 13, col = "#FF0000FF", border = NA)
dev.off()

if(FALSE) {
    z = png::readPNG("minPNG.png")
    z[,,1]    
p = pixRead("minPNG.png")
pixGetPixels(p)
p2 = pixConvertTo8(m)
pixGetPixels(p2)
    b = pixThresholdToBinary(p2, 1)
    pixGetPixels(b)
    b2 = pixInvert(b)
    m = pixGetPixels(b2)

    tr = z[,,1]
    tr[ tr > 0 ] = 1
}

