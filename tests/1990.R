library(Rtesseract)

f = system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract")
ts = tesseract(f, 'psm_auto')
Recognize(ts)
sym = getConfidences(ts, "symbol")
word = getConfidences(ts, "word")

