# Using the jpg rather than the png from that jpg file yields more errors in the OCR.
# Same with converting it to tiff.

img = "IMG_1234.jpg"

truth = readLines("IMG_1234_crop.txt")

library(Rtesseract)
w = ocr(img, "word", opts = c("tessedit_char_whitelist" = "0123456789."))
names(w)

miss = compareWords( names(w), truth)

table(ocr = miss$ocr, true = miss$true)


#
library(jpeg)
i = readJPEG(img)

api = tesseract(image = img, "tessedit_char_whitelist" = "0123456789.")
Recognize(api)
plot(api, level = "symbol", img = i, border = "grey")


# Now let's move to the bounding boxes for these.

#ri = GetIterator(api)
#bbox = lapply(ri, BoundingBox, level = "symbol")

bbox = ocr(img, "symbol", boundingBox = TRUE, opts = c("tessedit_char_whitelist" = "0123456789."))
m = do.call(rbind, bbox[ miss$symbolIndex ])[, -1]  # get rid of confidence.
rect(m[,1], nrow(i) - m[,2], m[,3], nrow(i) - m[,4], border = "red")




#  collapse(mapply(compareWord, names(w), truth))



