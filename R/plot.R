#         function(x, y, level = "word", ...) {
#             plot.OCR(x, level = level, ...)
#         })


plot.OCR =
function(x, y = "word",
         filename = if(!missing(x)) GetInputName(x) else "",         
         img = readImage(filename),
         bbox = getBoxes(x),
         border = if(confidence) getConfidenceColors(bbox) else "red",
         outer.border = border,
         cropToBoxes = FALSE, margin = .05,
         main = basename(filename),
         confidence = TRUE,
         ...)
{
    if(!is.matrix(bbox) && !is.data.frame(bbox))
       m = do.call(rbind, bbox)
    else
       m = bbox

    if(is.null(img)) {
        dims = getImageDims(x)
        nrow = dims[1]
        ncol = dims[2]
    } else {
        nrow = nrow(img)
        ncol = ncol(img)
    }
        

         # put the y's going from bottom to top, unlike their originals which are top to bottom.
    m[,2] = nrow - m[,2]
    m[,4] = nrow - m[,4]    

    
    if(cropToBoxes) {
       # The intent here is to crop the image so that we don't show it all but limit
       # it to a range that only includes the bounding boxes we observe.
    
       if(length(margin) == 1)
          margin = c(1 - margin, 1 + margin)
       

       mx = c(min(m[,1]), max(m[,3]))*margin
       my = c(min(m[,2]), max(m[,4]))*margin

          # make certain mx and my are > 0.  Could mx[2] or my[2] be negative
       mx[1] = max(0, mx[1])
       my[1] = max(0, my[1])       
       
       img = img[ sort(nrow - seq(as.integer(my[1]), as.integer(my[2]))), seq(as.integer(mx[1]), as.integer(mx[2])), ]
    
    } else {  # show whole image
       mx = c(0, ncol)
       my = c(0, nrow)
    }

    plot(0, type = "n", xlab = "", ylab = "", xlim = mx, ylim = my, ..., xaxs = "i", yaxs = "i")
    
       
    if(!is.null(img) && !is.na(img))
        rasterImage(img, mx[1], my[1], mx[2], my[2])    

        # Draw the bounding boxes for the detected elements.
    rect(m[,1],  m[,2], m[,3],  m[,4], border = border, ...)
    
        # And now the outer containing rectangle enclosing all the bounding boxes
    rect(min(m[,1]),  min(m[,4]), max(m[,3]),  max(m[,2]), border = outer.border)

    title(main)

     # return the modified bounding box so that people can continue to add the plot.
     # Recall the top and bottom have been "corrected" for use on this plot.
    invisible(m)
}

#setMethod("plot", "TesseractBaseAPI",   plot.OCR)
setMethod("plot", "TesseractBaseAPI",
            function(x, y, ...) {
             if(missing(y))
                 y = "word"
             plot.OCR(x, y, ...)
           })


plot.ConfusionMatrix =
function(x, y, col = rgb(seq(1, 0, length = max(x)), 1, 1), xlab = "Actual", ylab = "Predicted", ...)
{
  image(x, col = col, axes = FALSE, ..., xlab = xlab, ylab = ylab)
  box()
  u = par()$usr
  d = (u[2] - u[1])/nrow(x)
  axis(1, seq(u[1] + d/2, by = d, length = nrow(x)), rownames(x))

  d = (u[4] - u[3])/ncol(x)
  axis(2, seq(u[3] + d/2, by = d, length = ncol(x)), colnames(x))  
}

plotSubImage = # plot.BoundingBox =
function(box, img, ...)
{
  pos = box
  k = img[ pos[2]:pos[4],  pos[1]:pos[3], ]
  plot(0, type = "n", xlim = c(0, ncol(k)), ylim = c(0, nrow(k)), ...)
  rasterImage(k, 0, 0, ncol(k), nrow(k))
}




getConfidenceColors =
function(bbox, confidences = bbox[, "confidence"],
         numColors = 10,
         colors = colorRampPalette(c("#f7fcf5", "#005a32"))(numColors),
         intervals = quantile(confidences, seq(0, 1, by = .1)))
{
   i = cut(confidences, intervals )
   structure(colors[ i ], names = as.character(i))
}
