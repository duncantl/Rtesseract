setMethod("plot", "TessBaseAPI",
          function(x, y, level = "word", ...) {
              plot.OCR(api, level = level, ...)
          })


plot.OCR =
function(api, level = "word",
         ri = GetIterator(api),
         filename = GetInputName(api),
         img = readPNG(filename),
         bbox = lapply(ri, BoundingBox, level),
         border = "red",
         outer.border = "green",
         ...)
{
    m = do.call(rbind, bbox)
    xr = range(m[, 1], m[,3])
    yr = range(m[, 2], m[,4])

    r = nrow(img)
    c = ncol(img)
    
    plot(0, type = "n", xlab = "", ylab = "", xlim = c(0, c), ylim = c(0, r), ...)    
    rasterImage(img, 0, 0, c, r)
    rect(m[,1], r - m[,2], m[,3], r - m[,4], border = border)
    
    rect(min(m[,1]), r - min(m[,2]), max(m[,3]), r - max(m[,4]), border = outer.border)

    NULL
}
