library(Rtesseract)
a = tesseract()

names(a)

a$tosp_near_lh_edge
a$tosp_near_lh_edge = 1
a$tosp_near_lh_edge

a[[ "tosp_near_lh_edge" ]]

a[[ "tosp_near_lh_edge" ]] = 0

v = c("crunch_debug", "textord_baseline_debug" ,  "debug_noise_removal", "tessedit_write_images")
a[v]
a[ v ] = rep(1, 4)
a[v]

