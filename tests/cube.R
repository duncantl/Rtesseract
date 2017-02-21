
library(Rtesseract)

f = system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract")

ts = tesseract(init = FALSE)
Init(ts, engineMode = 'OEM_TESSERACT_CUBE_COMBINED')
SetPageSegMode(ts, 'psm_auto')
SetInputName(ts, f)
Recognize(ts)
Rtesseract:::oem(ts)

bbox = GetBoxes(ts)


ts2 = tesseract(init = FALSE)
Init(ts2, engineMode = 'OEM_CUBE_ONLY')
SetPageSegMode(ts2, 'psm_auto')
SetInputName(ts2, f)
Recognize(ts2)

bbox2 = GetBoxes(ts2)

