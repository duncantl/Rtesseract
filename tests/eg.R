# This file shows how we can use the ORC facilities
# like we use the C++ API in tesseract's baseapi.h header file
# but from R.

library(Rtesseract)

 # Create the API object
api = tesseract()
 # Initialize the OCR mechanis with a language, "eng" by default.
Init(api)

# Set the image we want to read
f = system.file("images", "OCRSample2.png", package = "Rtesseract")
pix = pixRead(f)
SetImage(api, pix)

# Run the ORC on this image.
Recognize(api)

if(FALSE){
# Get the results object
ri = GetIterator(api)


# Apply a C routine or an R function to each of the elements of the results
sym = getNativeSymbolInfo("r_getConfidence")
conf = lapply(ri, sym$address, 3L)

conf1 = lapply(ri, Confidence, 3L)
identical(conf, conf1)

#sapply doesn't work as dispatch to lapply() is not done.
#conf2 = sapply(ri, Confidence, 3L)

bbox = lapply(ri, BoundingBox, 3L)

alts = lapply(ri, GetAlternatives, "symbol")
}


