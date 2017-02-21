library(Rtesseract)

f = system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract")

ts = tesseract(f)
#Recognize(ts)
bbox = GetBoxes(ts)

library(png)
colors = GetConfidenceColors(bbox)  # Rtesseract:::
plot(ts, bbox = bbox, border = colors)


dev.new()
m = plot(ts, img = NULL, bbox = bbox, border = colors)
rect(m[,1], m[,2], m[,3], m[,4], col = colors)

dev.new()
m = plot(ts, img = NULL, bbox = bbox, border = colors, cropToBoxes = TRUE)
rect(m[,1], m[,2], m[,3], m[,4], col = colors)



# default now
dev.new()
plot(ts, bbox = bbox, border = colors)

