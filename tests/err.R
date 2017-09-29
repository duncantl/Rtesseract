# This checks that we don't exit the R process but catch the error that was
# raised via our libRexit or atexit() mechanism.
library(Rtesseract)
api = tesseract()

file.create("testExit")
x = tryCatch(ReadConfigFile(api, "Experiments/bad_config"), error = function(e) file.remove("testExit"))
# This is  dumb test because if the tesseract  library invokes the exit() call, we won't get to the next line.
# We could write a file and then delete if we catch the error and have  following related test, e.g. err1.R
# that checks if the file has been deleted and if not then signals an error from err.R
stopifnot(is(x, 'try-error'))

