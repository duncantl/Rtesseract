library(RCIndex)
library(RCodeGen)
inc = "/usr/local/include/tesseract"
version = "3.05"

# For 5.1 on my machine with clang setup.
# inc = c("/Users/duncan/TEMP/include", "/Users/duncan/local/include/c++/v1", "/Users/duncan/local/lib/clang/12.0.0/include")

#inc = "~/Projects/OCR/tess4/api"
#version = "4.0"

tu = createTU("tess.cc", include = inc)

e = getEnums(tu, "tesseract") # Filter out the other enums.

# k = getCppClasses(tu)

zfile = sprintf("../R/z_enumDefs_%s.R", version)
#cat(makeEnumClass(e$PageSegMode), file = "../R/PageSegMode.R", sep = "\n")
cat(paste("if(tesseractVersion(runTime = FALSE) == c('", version[1], "')) {\n", sep = ""),
    unlist(lapply(e, makeEnumClass)),
    "\n\n\n}\n\n",
    file = zfile, sep = "\n")



if(FALSE) {
# makeEnumDef(e$PageSegMode, namespace = "tesseract"),
ccode = lapply(e, function(e) {
                    p = getCursorSemanticParent(e@def)
                    makeEnumDef(e, namespace = if(p$kind == CXCursor_Namespace) "tesseract" else character())
                  })
cat('#include "Rtesseract.h"',
    '#include "RConverters.h"', "",
    unlist(ccode),
   sep = "\n", file = "../src/PageSegMode.cc")
}
