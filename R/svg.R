# Very simple SVG output from our OCR.
#
#  Add
#
#    + Detect skew
#
#
#  To the display in browser
#   + have the alternatives be a pull down menu on each 
#   + a slider that thresholds the confidence level. As we change it, elements with confidence above that are shown and below hidden.
#      + be clever about updating only the new ones, i.e. not looping over all the elements again.
#   + display the original image beside the text
#   + allow the viewer to rotate and we take this as skew and transform the text accordingly to straighten it up.
#

mkSVG =
function(bbox, dims,  alt = NULL, col = GetConfidenceColors(bbox), alpha = .8, confThreshold = .2)
{
    w = bbox$confidence >= confThreshold
    bbox = bbox[w,]
    if(length(alt))
        alt = alt[w]
    
    dims = as.numeric(dims)
    col = Rtesseract:::toAlpha(col, alpha)
    txt =  c(sprintf('<svg width="%f" height="%f">', dims[1], dims[2]),
             sprintf('<text x="%f" y="%f" fill="%s">%s</text>', bbox$left, bbox$top,  col, gsub("&", "&amp;", bbox$text)),
             sprintf('</svg>'))
}



# Examples 

if(FALSE) {
v = mkSVG(bb, c(1365, 1024))
cat("<!DOCTYPE html><html><body>", v, "</body></html>", file = "Moore_003.html", sep = "\n")
}


if(FALSE) {

    jpegs = list.files(pattern = "jpg$")
    bboxes = lapply(jpegs, function(f) {print(f); GetBoxes(f)})
    vv = mapply(function(bb, filename) c(sprintf('<a name="%s" href="%s" target="_blank">%s</a><br/>', filename, filename, filename),
                                         mkSVG(bb, c(1365, 1024), col = "black", alpha = 1),
                                         '<hr width="50%"/>'),
                bboxes, jpegs)

    cat("<!DOCTYPE html><html><body>",
        sprintf('<a href="#%s">%d</a>', jpegs, seq(along = jpegs)),
        '<hr width="50%"/>',
        unlist(vv),
        "</body></html>",
        file = "Moore.html", sep = "\n")    
}    
