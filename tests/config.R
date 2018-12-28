library(Rtesseract)
api = tesseract()
ov = GetVariables(api)
ReadConfigFile(api, "debug_config")
v = GetVariables(api)
i = (names(v) != names(ov))
v[i]

