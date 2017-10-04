library(Rtesseract)
f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
f = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")
pix = pixRead(f)
tess = tesseract(pix)
plot(tess, img = pix)

# Now do it without the pix
# Could set the name on the tesseract object. Will that cause it to re-recognize?
#SetInputName(tess, f)
plot(tess, filename = f)



