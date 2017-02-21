library(Rtesseract)

ts = tesseract(system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract"))
SetVariables(ts, save_best_choices = TRUE)
Recognize(ts)
a = GetAlternatives(ts)

