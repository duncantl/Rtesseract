library(Rtesseract)

vars = list(chop_enable =  0L, wordrec_enable_assoc = 0L, tessedit_create_boxfile = 1L) # , tessedit_resegment_from_boxes = 1L, tessedit_make_boxes_from_boxes = 1L)


ts = tesseract(system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract"), "psm_auto") # , .vars = vars)
ReadConfigFile(ts, c("makebox", "batch.nochop"), force = TRUE)
PrintVariables(ts)[names(vars)]

GetPageSegMode(ts)
#SetPageSegMode(ts, "psm_auto")

Recognize(ts)

bbb = BoundingBoxes(ts)
print(max(bbb[,3]  - bbb[,1]))


if(FALSE) {
ans = .Call("R_Tesseract_RenderBoxes", ts)

bb = readBoxFile("/tmp/ffff.box")
print(max(bb[,3]  - bb[,1]))
}




