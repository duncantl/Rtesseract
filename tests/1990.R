library(Rtesseract)

f = "inst/trainingSample/eng.tables.exp0.png"
ts = tesseract(f, 'psm_auto')
Recognize(ts)
sym = getConfidences(ts, "symbol")
word = getConfidences(ts, "word")

