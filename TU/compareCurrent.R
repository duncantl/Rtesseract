# Compare the enums we compute in tu.R to those values in
# the current package.
library(Rtesseract)
ns = asNamespace("Rtesseract")
curValues = lapply(names(e), getFromNamespace, ns)

same = mapply(function(n, cur) all.equal(n@values, cur), e, curValues)

# Will be a character if not the same.
stopifnot(is.logical(same) && all(same))
