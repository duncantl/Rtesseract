
img = "IMG_1255_crop.jpg"

trueWords = scan("IMG_1255_crop.txt", what = "")
truth = matrix(trueWords, , 4, byrow = TRUE)

library(Rtesseract)
w = ocr(img, "word", opts = c("tessedit_char_whitelist" = "0123456789."))
names(w)

miss = compareWords( names(w), truth)

tt = table(true = miss$true, ocr = miss$ocr)
class(tt) = "ConfusionMatrix"
plot(tt)

mc = nrow(miss)/sum(nchar(truth)) # 60% missclassified.



mainDigits =
 do.call(rbind, by(miss, miss$wordIndex,
                   function(x) {
                       n = nchar(gsub("\\..*", "", x$trueWord))
                       x[ x$position <= n, ]
                   }))

nrow(mainDigits)/sum(nchar(truth))  # Down to 48% on these digits.

library(jpeg)
i  = readJPEG(img)


api = tesseract(image = img, "tessedit_char_whitelist" = "0123456789.")
Recognize(api)
par(mfrow = c(1, 1))
plot(api, level = "symbol", img = i, border = "grey")

 # Add the bounding boxes for the misclassified characters.
bbox = ocr(img, "symbol", boundingBox = TRUE, opts = c("tessedit_char_whitelist" = "0123456789."))
m = do.call(rbind, bbox[ miss$symbolIndex ])[, -1]  # get rid of confidence.
rect(m[,1], nrow(i) - m[,2], m[,3], nrow(i) - m[,4], border = "red")


conf = sapply(bbox, `[`, 1)
plot(density(conf))
lines(density(conf[miss$symbolIndex]), col = "red")
lines(density(conf[-miss$symbolIndex]), col = "green")

alts = ocr(img, "symbol", alternatives = TRUE, opts = c("tessedit_char_whitelist" = "0123456789."))
table(sapply(alts, length))
  # so 3 have alternatives.
table(sapply(alts[miss$symbolIndex], length))
 # And these three are in the misclassified ones.

i = which(sapply(alts, length) > 2)
alts[i]
miss[ miss$symbolIndex %in% i, ]



