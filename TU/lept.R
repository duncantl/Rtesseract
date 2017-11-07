library(RCIndex)
library(RCodeGen)
tu = createTU("leptonica.cc", include = "/usr/local/include")
tu = createTU("leptonica.cc", include = "~/local/include/leptonica")

e = getEnums(tu)

r = getRoutines(tu)

iff = e[[ which(sapply(e, function(x) all(grepl("^IFF", names(x@values))))) ]]
iff@name = "InputFileFormat"
cat(makeEnumClass(iff), file = "../R/IFF.R", sep = "\n")


ds = getDataStructures(tu)
i = grepl("leptonica", sapply(ds, function(x) getFileName(x@def)))
ds = ds[i]

#cat(makeEnumClass(e$PageSegMode), file = "../R/PageSegMode.R", sep = "\n")
#cat(unlist(lapply(e, makeEnumClass)), file = "../R/PageSegMode.R", sep = "\n")

# makeEnumDef(e$PageSegMode, namespace = "tesseract"),
# ccode = lapply(e, function(e) {
#                    p = getCursorSemanticParent(e@def)
#                    makeEnumDef(e, namespace = if(p$kind == CXCursor_Namespace) "tesseract" else character())
#                  })
#cat('#include "Rtesseract.h"',
#    '#include "RConverters.h"', "",
#    unlist(ccode),
#   sep = "\n", file = "../src/PageSegMode.cc")
