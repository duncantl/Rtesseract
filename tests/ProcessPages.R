# The idea here is to mimic the tesseract command line
# We seem to be doing the same thing up to where it calls api.ProcessPages()
# So we will try that.

library(Rtesseract)

f = "../Matt/1990_p44.png"
ts = tesseract(f, "psm_auto")

print(SetPageSegMode(ts, 3))
print(GetPageSegMode(ts))

# SetOutputName(ts, "/tmp/foo.rout.txt")

.Call("R_TessBaseAPI_ProcessPages", ts, f, NULL, 0L, NULL)
out = "/tmp/foo.rout.txt"
stopifnot(file.exists(out))
tt = readLines(out)
head(tt)



