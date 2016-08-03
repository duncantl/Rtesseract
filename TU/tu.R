library(RCIndex)
tu = createTU("tess.cc", include = "/usr/local/include/tesseract")

e = getEnums(tu)

k = getCppClasses(tu)
