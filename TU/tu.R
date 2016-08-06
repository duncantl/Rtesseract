library(RCIndex)
library(RCodeGen)
tu = createTU("tess.cc", include = "/usr/local/include/tesseract")

e = getEnums(tu)

k = getCppClasses(tu)


cat(makeEnumClass(e$PageSegMode), file = "../R/PageSegMode.R", sep = "\n")
cat('#include "Rtesseract.h"', '#include "RConverters.h"', "", makeEnumDef(e$PageSegMode, namespace = "tesseract"), sep = "\n", file = "../src/PageSegMode.cc")
