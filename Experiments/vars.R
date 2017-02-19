library(Rtesseract)

ts = tesseract(system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract"))
print(PrintVariables(ts)[c("chop_enable", "wordrec_enable_assoc")])


vars = list(chop_enable =  0L, wordrec_enable_assoc = 0L, tessedit_create_boxfile = 1L) # , tessedit_resegment_from_boxes = 1L, tessedit_make_boxes_from_boxes = 1L)
ts = tesseract(system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract"), .vars = vars)
print(PrintVariables(ts)[names(vars)])

ReadConfigFile(ts, c("makebox", "batch.nochop"), force = TRUE)
print(PrintVariables(ts)[names(vars)])
