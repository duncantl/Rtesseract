library(Rtesseract)
api = tesseract()
ov = GetVariables(api)
ReadConfigFile(api, "tests/debug_config", debug = TRUE)
v = GetVariables(api)
i = (names(v) != names(ov))
v[i]
