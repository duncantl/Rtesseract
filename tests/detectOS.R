library(Rtesseract)
f = system.file("images", "Rotated.png", package = "Rtesseract")
ts = tesseract(f)
Recognize(ts)
o = .Call("R_TessBaseAPI_DetectOS", ts)

