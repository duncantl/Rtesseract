library(Rtesseract)
img = "IMG_1236_crop.png"

trueWords = scan("IMG_1236_crop.txt", what = "")
truth = matrix(trueWords, , 4, byrow = TRUE)

# syms = apply(truth, 1, function(x) strsplit(paste(x, collapse = " "), "")[[1]])

library(Rtesseract)
w = ocr(img, "word", opts = c("tessedit_char_whitelist" = "0123456789."))


# compare w and truth by word, breaking down characters.

miss = compareWords( names(w), trueWords)

tt = table(true = miss$true, ocr = miss$ocr)
class(tt) = "ConfusionMatrix"
plot(tt)


if(FALSE) {
library(ggplot2)
plot = ggplot(as.data.frame(tt))
plot + geom_tile(aes(x=ocr, y=true, fill=Freq)) + scale_x_discrete(name="Actual Class") + scale_y_discrete(name="Predicted Class") + scale_fill_gradient(breaks=seq(from=-.5, to=4, by=.2)) + labs(fill="Normalized\nFrequency")
}


mc = nrow(miss)/sum(nchar(truth))
# 50% misclassification 

# Note that we get a lot of the 0's after the decimal place wrong.

mainDigits =
 do.call(rbind, by(miss, miss$wordIndex,
                   function(x) {
                       n = nchar(gsub("\\..*", "", x$trueWord))
                       x[ x$position <= n, ]
                   }))

nrow(mainDigits)/sum(nchar(truth))  # 31%


library(png)
i  = readPNG(img)

#i = i - mean(i[1:10, 1:10, 1:2])  # min(i)
#i[  i < 0 ]  = 0

api = tesseract(image = img, "tessedit_char_whitelist" = "0123456789.")
Recognize(api)
par(mfrow = c(1, 1))
plot(api, level = "symbol", img = i, border = "grey")

bbox = ocr(img, "symbol", boundingBox = TRUE, opts = c("tessedit_char_whitelist" = "0123456789."))
m = do.call(rbind, bbox[ miss$bboxIndex ])[, -1]  # get rid of confidence.
rect(m[,1], nrow(i) - m[,2], m[,3], nrow(i) - m[,4], border = "red")


rect(m[1,1], nrow(i) - m[1,2], m[1,3], nrow(i) - m[1,4], border = "blue")
# Note that we get a lot of the digits after the decimal places wrong.

pos = bbox[[ miss$bboxIndex[1] ]][-1]
k = i[ pos[2]:pos[4],  pos[1]:pos[3], ]
plot(0, type = "n", xlim = c(0, ncol(k)), ylim = c(0, nrow(k)))
rasterImage(k, 0, 0, ncol(k), nrow(k))
# Now in plot.BoundingBox


par(mfrow = c(12, 12), mar = c(0, 0, 0, 0))
invisible(lapply(bbox[ miss$bboxIndex ],
                  function(box)
                      plot.BoundingBox(box[-1], i, axes = FALSE)))


