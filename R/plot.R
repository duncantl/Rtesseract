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


plot.ConfusionMatrix =
function(x, y, col = rgb(seq(1, 0, length = max(x)), 1, 1), xlab = "Actual", ylab = "Predicted", ...)
{
  image(x, col = col, axes = FALSE, ..., xlab = xlab, ylab = ylab)
  box()
  u = par()$usr
  d = (u[2] - u[1])/nrow(tt)
  axis(1, seq(u[1] + d/2, by = d, length = nrow(tt)), rownames(tt))

  d = (u[4] - u[3])/ncol(tt)
  axis(2, seq(u[3] + d/2, by = d, length = ncol(tt)), colnames(tt))  
}

plot.BoundingBox =
function(box, img, ...)
{
  pos = box
  k = i[ pos[2]:pos[4],  pos[1]:pos[3], ]
  plot(0, type = "n", xlim = c(0, ncol(k)), ylim = c(0, nrow(k)), ...)
  rasterImage(k, 0, 0, ncol(k), nrow(k))
}
