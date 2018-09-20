#         function(x, y, level = "word", ...) {
#             plot.OCR(x, level = level, ...)
#         })


plot.OCR =
function(x, y = "word",
         filename = if(!missing(x)) GetInputName(x) else "",         
         img = readImage(filename),
         bbox = GetBoxes(x),
         border = if(confidence) GetConfidenceColors(bbox) else "red",
         outer.border = border,
         cropToBoxes = FALSE, margin = .05,
         main = basename(filename),
         confidence = TRUE, fillBoxes = FALSE,
         alpha = 0.4,
         dims = NULL,
         legend = FALSE,
         ...)
{
    if(!is.matrix(bbox) && !is.data.frame(bbox))
       m = do.call(rbind, bbox)
    else
        m = bbox


    if(is.null(dims)) {
        if(!missing(x))
           dims = GetImageDims(x)
        else if(!missing(bbox))
           dims = c(max(bbox[, c(2, 4)]), max(bbox[, c(1, 3)]))
        else if(is.null(img))
           stop("We need a way to get the image dimensions - the tesseract object, the bounding box (bbox) or the image")
                       
    }

    if(is.null(img)) {
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
        # Needs to be >= 1, since we are using this as an index
        mx[1] = max(1, mx[1])
        my[1] = max(1, my[1])
        # Need to make sure the max value is not larger than the biggest dim
        mx[2] = min(mx[2], ncol)
        my[2] = min(my[2], nrow)
        
       img = img[ sort(nrow - seq(as.integer(my[1]), as.integer(my[2]))), seq(as.integer(mx[1]), as.integer(mx[2])), ]
    
    } else {  # show whole image
       mx = c(0, ncol)
       my = c(0, nrow)
    }

    plot(0, type = "n", xlab = "", ylab = "", xlim = mx, ylim = my, ..., xaxs = "i", yaxs = "i")
           
    if(!is.null(img)) # && !is.na(img))
       rasterImage(as.raster(img), mx[1], my[1], mx[2], my[2])    

        # Draw the bounding boxes for the detected elements.
    rect(m[,1],  m[,2], m[,3],  m[,4], border = border,
        col = if(fillBoxes) toAlpha(border, alpha = alpha) else NULL,
         ...)

        # And now the outer containing rectangle enclosing all the bounding boxes
    rect(min(m[,1]),  min(m[,4]), max(m[,3]),  max(m[,2]), border = outer.border)

    if(legend){
        leg = border[sort(unique(names(border)), decreasing = TRUE)]
        legend("topright", legend = names(leg), fill = leg)
    }

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


plotSubsets =
function(bbox, img, nrow = 4, ncol = 4,
         titles = paste("OCR: ", row.names(bbox),
                        ", conf: ", round(bbox[,"confidence"],0)),
         ...)

{
    old.par = par()[c("mfrow","mar","oma")]
    on.exit(par(old.par))
    
    par(mfrow = c(nrow, ncol),
        mar = c(1, 1, 1, 1),
        oma = c(1, 1, 1, 1))
    
    sapply(1:nrow(bbox), function(i)
        plotSubImage(box = bbox[i, 1:4], img,
                     xlab = "", ylab = "", xaxt = "n", yaxt = "n",
                     main = titles[i], ...))
    
    invisible(bbox)        
} 



GetConfidenceColors =
function(bbox, confidences = bbox[, "confidence"],
         numColors = 10,
         colors = colorRampPalette(colorEnds)(numColors),
         colorEnds = c("#f7fcf5", "#005a32"),
         intervals = quantile(confidences, seq(0, 1, by = 1/numColors)))
{
    # prevent cut from returning NAs
    intervals[1] = 0
    intervals[numColors+1] = 100
    
    i = cut(confidences, unique(intervals) )
    structure(colors[ i ], names = as.character(i))
}

toAlpha =
    function(colors, alpha)
{
    # Converts colors to versions with some transparency
    if(any(alpha < 0 | alpha > 1))
       stop("Alpha must be between 0 and 1")
    col = col2rgb(colors, TRUE) / 255
    col["alpha",] = alpha
    rgb(col["red",], col["green",], col["blue",], col["alpha",])
}


getDims =
function(bbox)
{
    c(max(bbox[, c(2, 4)]), max(bbox[, c(1, 3)]))
}

showBoxes =
    # getDims(bbox)
function(bbox, dim = par()$usr[c(4, 2)], ...)
{
    m = bbox
    m[,2] = dim[1] - m[,2]
    m[,4] = dim[1] - m[,4]
#browser()
    rect(m[,1], m[,2], m[,3], m[,4], ...)
}
