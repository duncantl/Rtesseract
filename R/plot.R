setMethod("plot", "TesseractBaseAPI",
          function(x, y, level = "word", ...) {
              plot.OCR(x, level = level, ...)
          })


plot.OCR =
function(api, level = "word",
         ri = GetIterator(api),
         filename = GetInputName(api),
         img = readImage(filename),
         bbox = BoundingBoxes(ri, level),
         border = "red",
         outer.border = "green",
         cropToBoxes = FALSE, margin = .05,
         ...)
{
    if(!is.matrix(bbox))
       m = do.call(rbind, bbox)
    else
       m = bbox

# The body of the if and the else could and should be consolidated to move the rasterImage, rect, rect calls after
# the computations, as it used to be. But this involves both using the y values reoriented to bottom to top.
    if(cropToBoxes) {
       # The intent here is to crop the image so that we don't show it all but limit
       # it to a range that only includes the bounding boxes we observe.
    
       if(length(margin) == 1)
          margin = c(1 - margin, 1 + margin)
       
    
         # put the y's going from bottom to top, unlike their originals which are top to bottom.    
       orig = dim(img)
       m[,2] = orig[1] - m[,2]
       m[,4] = orig[1] - m[,4]
    
       
       mx = c(min(m[,1]), max(m[,3]))*margin
       my = c(min(m[,2]), max(m[,4]))*margin
    
       img = img[ sort(orig[1] - seq(as.integer(my[1]), as.integer(my[2]))), seq(as.integer(mx[1]), as.integer(mx[2])), ]
    
       plot(0, type = "n", xlab = "", ylab = "", xlim = mx, ylim = my, ..., xaxs = "i", yaxs = "i")
    
       
       if(!is.null(img) && !is.na(img))
          rasterImage(img, mx[1], my[1], mx[2], my[2])
       
        # Draw the bounding boxes for the detected elements.
       rect(m[,1],  m[,2], m[,3],  m[,4], border = border)
    
        # And now the outer containing rectangle enclosing all the bounding boxes
       rect(min(m[,1]),  min(m[,4]), max(m[,3]),  max(m[,2]), border = outer.border)    
    
    } else {  # show whole image
       r = nrow(img)
       c = ncol(img)
       
       plot(0, type = "n", xlab = "", ylab = "", xlim = c(0, c), ylim = c(0, r), ...)
       
       if(!is.null(img) && !is.na(img))
          rasterImage(img, 0, 0, c, r)
        # Draw the bounding boxes for the detected elements.
       rect(m[,1], r - m[,2], m[,3], r - m[,4], border = border)
        # And now the outer containing rectangle enclosing all the bounding boxes
       rect(min(m[,1]), r - min(m[,2]), max(m[,3]), r - max(m[,4]), border = outer.border)
    }
    
    NULL
}


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
