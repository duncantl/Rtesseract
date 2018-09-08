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
#       + as we scroll in one, scroll in the other to track. 
#   + allow the viewer to rotate and we take this as skew and transform the text accordingly to straighten it up.
#   + allow viewer to mark an empty region as missing some text.
#
#   + allow viewer to mark a word as correct
#      + Currently selects the first item
#   + allow viewer to enter text that is not an alternative.
#      + if she selects the last item, we bring up a prompt with the current value.
#
#   + Undo facilities

mkSVG =
function(bbox, dims,  alt = NULL, col = GetConfidenceColors(bbox), alpha = .8, confThreshold = 0.0)
{
    w = bbox$confidence >= confThreshold
    bbox = bbox[w,]
    if(length(alt))
        alt = alt[w]
    
    dims = as.numeric(dims)
    col = Rtesseract:::toAlpha(col, alpha)
    idx = seq(length = nrow(bbox))
    txt =  c(sprintf('<svg width="%f" height="%f">', dims[1], dims[2]),
             sprintf('<text id="%d" index="%d" x="%f" y="%f" fill="%s">%s</text>', idx, idx, bbox$left, bbox$top,  col, gsub("&", "&amp;", bbox$text)),
             sprintf('</svg>'))
}


mkSVGData =
function(bbox, alts)
{
    idx = 1:nrow(bbox)
    o = order(bbox$confidence)

    tmp = lapply(idx,
                 function(i) {
                     list(correct = FALSE, alts = character())
                 })
    names(tmp) = idx
    
    list(confByIndex = list(idx = idx[o], confidences = bbox$confidence[o]),
         data = tmp)
}

mkHTML =
function(bbox, dims, alts, template = "svgValidate_template.html")
{
    svg = mkSVG(bbox, dims)
    if(is.character(template))
        template = htmlParse(template)
    
    osvg = getNodeSet(template, "//svg")
    replaceNodes(osvg[[1]], xmlRoot(xmlParse(svg)))

    data = mkSVGData(bbox)
    h = getNodeSet(template, "//head")
    newXMLNode("script", attrs = c(type = "text/javascript"),
               paste("var conf =", toJSON(data$conf), ";"), parent = h)

    newXMLNode("script", attrs = c(type = "text/javascript"),
               paste("var data =", toJSON(data$data), ";"), parent = h)    

    m = getNodeSet(template, "//i[@id = 'minConf']")[[1]]
    xmlValue(m) = floor(min(bbox$conf))
    m = getNodeSet(template, "//i[@id = 'maxConf']")[[1]]
    xmlValue(m) = ceiling(max(bbox$conf))
    m = getNodeSet(template, "//input[@id = 'confSlider']")[[1]]
    xmlAttrs(m)  = c(value = ceiling(max(bbox$conf)))
    

    invisible(template)
}

toSVGFile =
function(bbox, dims, file, svg = mkSVG(bbox, dims, ...), ...)
{
  cat("<!DOCTYPE html><html><body>", unlist(svg), "</body></html>", file = file, sep = "\n")
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
