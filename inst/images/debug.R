
library(Rtesseract)
api = tesseract("SMITHBURN_1952_p3.tiff")
SetVariables(api, "crunch_debug" = 1, "textord_baseline_debug" = 1,  "debug_noise_removal" = 1, "tessedit_write_images" = 1)

Recognize(api)

