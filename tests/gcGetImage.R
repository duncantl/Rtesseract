library(Rtesseract)

# This differs from gcGetImage{2,3}.R.
# These other 2 rm() the tesseract instance and continue to use the Pix object
# returned via GetImage().  So the tesseract instance doesn't free the image.
# However, in this test, we release the Pix after we GetImage() and then continue
# to use the tesseract.
# See also the stand-alone test in ref.cc in RefCount/ (outside of this R package repository)

f = system.file("images", "OCRSample2.png", package = "Rtesseract")
gctorture(TRUE)
api = tesseract(f)

.Call("R_TessBaseAPI_GetInputImage_refcount", api)
# refcount = 2

i = GetImage(api)
gc()
.Call("R_TessBaseAPI_GetInputImage_refcount", api)
# 3


rm(i)
gc()
.Call("R_TessBaseAPI_GetInputImage_refcount", api)

bb = GetBoxes(api)
print(bb)
rm(api)  # problem here! Pix with same address as i causing grief.
gc()
# Seems to be freeing this twice. (We have a modified version of leptonica to see the actual freeing.
# [leptonica] freeing PIX 0x108f4e0c0, refcount = 0, 2017-07-19T14:00:36-07:00
# [leptonica] freeing PIX 0x108f4e0c0, refcount = -1, 2017-07-19T14:00:36-07:00
# If we don't execute the GetImage() and rm(i), all is fine.

