library(Rtesseract)

f = system.file("images", "1990_p44.png", package = "Rtesseract")
ts = tesseract(f)

Recognize(ts)
bb = BoundingBoxes(ts)

library(png)
img = readPNG(GetInputName(ts))

i = which(rownames(bb) == "MEAN")
if(length(i))
  bb = bb[ bb[, "top.right.y"] <  bb[i, "top.right.y"], ]

plot(ts, bbox = bb, img = img)

# Now crop to the boxes.
plot(ts, bbox = bb, img = img, cropToBoxes = TRUE, margin = .05) # , margin = c(.93, 1.15))







