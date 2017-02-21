if(FALSE){
library(Rtesseract)
api = tesseract()
ov = GetVariables(api)
ReadConfigFile(api, "tests/debug_config")
v = GetVariables(api)
i = (names(v) != names(ov))
v[i]
}
