library(Rtesseract)

f = system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract")

trace(Recognize)

ts = tesseract(f)
Recognize(ts)
bbox = getBoxes(ts)

library(png)


colors = Rtesseract:::getConfidenceColors(bbox)
plot(ts, bbox = bbox, border = colors)


m = plot(ts, img = NULL, bbox = bbox, border = colors)
rect(m[,1], m[,2], m[,3], m[,4], col = colors)

