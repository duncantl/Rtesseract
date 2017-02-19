library(Rtesseract)
f = system.file("images", "OCRSample2.png", package = "Rtesseract")
ts = tesseract(, PSM_AUTO)
#SetOutputName(ts, "tmp")
#ReadConfigFile(ts, "pdf", TRUE)  # or /usr/local/share/tessdata/configs/pdf
#Recognize(ts)

#vars = PrintVariables(ts)
render = .Call("R_TessPDFRender", "tmp", GetDatapath(ts))
.Call("R_TessBaseAPI_ProcessPages", ts, f, character(), 0L, render)
# Need to finalize the render object so that it flushes the file contents.
rm(render)
gc()
gc()
#End(ts)



