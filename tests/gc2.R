library(Rtesseract)

# Read a Pix and discard it.
f = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")
p = pixRead(f)
rm(p)
gc()


# Read the Pix, set it as the image for a tesseract, discard it and
# check that tesseract still has access to it. (It is a copy that tesseract created.)
p = pixRead(f)
t = tesseract()
SetImage(t, p)
rm(p)
gc()
# Use the image
b = GetText(t)
rm(t)
gc()
# Clear tesseract and GC.




