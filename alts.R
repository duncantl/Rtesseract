library(Rtesseract)
f = system.file("images", "IMG_1234.jpg", package = "Rtesseract")
ans = .Call("R_ocr_alternatives", f, c("tessedit_char_whitelist" = "0123456789.", save_blob_choices = "T"), 3L)
# , "save_best_choices" = "T",