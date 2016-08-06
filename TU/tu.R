library(RCIndex)
library(RCodeGen)
tu = createTU("tess.cc", include = "/usr/local/include/tesseract")

e = getEnums(tu)

k = getCppClasses(tu)


#cat(makeEnumClass(e$PageSegMode), file = "../R/PageSegMode.R", sep = "\n")
cat(unlist(lapply(e, makeEnumClass)), file = "../R/PageSegMode.R", sep = "\n")

# makeEnumDef(e$PageSegMode, namespace = "tesseract"),
ccode = lapply(e, function(e) {
                    p = getCursorSemanticParent(e@def)
                    makeEnumDef(e, namespace = if(p$kind == CXCursor_Namespace) "tesseract" else character())
                  })
cat('#include "Rtesseract.h"',
    '#include "RConverters.h"', "",
    unlist(ccode),
   sep = "\n", file = "../src/PageSegMode.cc")
