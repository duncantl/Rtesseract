 library(Rtesseract);smithburn = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")          
 ts = tesseract(smithburn)
 bb = GetBoxes(ts)
 i = which(bb$text == "Zika")
plot(ts)
showPoints(bb[i,], , 100)


