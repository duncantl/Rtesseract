img = "IMG_1236_crop.tiff"

truth = matrix(scan("IMG_1236_crop.symbols", what = ""), , 4, byrow = TRUE)

syms = apply(truth, 1, function(x) strsplit(paste(x, collapse = " "), "")[[1]])


library(Rtesseract)
o = ocr(img, "symbol", opts = c("tessedit_char_whitelist" = "0123456789."))

w = ocr(img, "word", opts = c("tessedit_char_whitelist" = "0123456789."))

w = matrix(names(w), , 4, byrow = TRUE)

# compare w and truth by word, breaking down characters.








o = ocr(f, "textline", opts = c("tessedit_char_whitelist" = "0123456789."))

names(o) = gsub("\\n", "", names(o))
ll = gsub(" +", " ", names(o))
els = strsplit(ll, "")

syms[[1]] == els[[1]]

