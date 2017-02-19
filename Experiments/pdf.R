library(Rtesseract)

ts = tesseract(system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract"))
ReadConfigFile(ts, "pdf", TRUE)  # or /usr/local/share/tessdata/configs/pdf
Recognize(ts)

.Call("R_Tesseract_RenderAsPDF", ts, "/tmp/out", "/usr/local/share/tessdata")

