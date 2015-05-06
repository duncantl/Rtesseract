library(Rtesseract)
f = system.file("images", "IMG_1234.jpg", package = "Rtesseract")
# seg faults if set save_blob_choices = "T"
o = ocr(f, opts = c("tessedit_char_whitelist" = "0123456789.", "save_blob_choices" = "F"), "symbol")
