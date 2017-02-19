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
    
    xr = range(m[, 1], m[,3])
    yr = range(m[, 2], m[,4])

if(cropToBoxes) {
    # The intent here is to crop the image so that we don't show it all but limit
    # it to a range that only includes the bounding boxes we observe.

    if(length(margin) == 1)
       margin = c(1 - margin, 1 + margin)
    
browser()    
    mx = c(min(m[,1]), max(m[,3]))*margin
    my = c(min(m[,2]), max(m[,4]))*margin

    orig = dim(img)
    img = img[ seq(as.integer(my[1]), as.integer(my[2])), seq(as.integer(mx[1]), as.integer(mx[2])), ]

# So what was, e.g., x = 607, 690 should now be scaled to the new coordinate
# We have removed mx[1] (564) pixels from the left of the image
# So we should subtract that from 607
#    (607 - mx[1])
# And we have also 

# Start with image 300 rows x 1000 columns
# Boxes horizontally at x= 70 and ends at x = 90
# The left margin is .9*70 = 63. So we will start our new image at column 63.
# Column 1 of the subimage is 63 of the original image.
# The rightmost box starts at 800 and ends at 840.
# So the right margin is 800*1.15 = 920
# So our image subset is from 63 - 920
#
# So an original value of 63 should map to 0  (actually 1 but let's not worry about that now)
#   (orig - mx[1])*scale
# And an original value of 1000 should map to 920
#  (1000 - 63)*scale = 937*scale = 920
# scale = 920/937
#
# So the scale is new number of columns/(original number of columns - mx[1])

    r = nrow(img)
    c = ncol(img)

 # Scale the boxes to the new  coordinate system

    xscale = function(x) x / (diff(mx)/orig[2])  - mx[1]#min(m[,1])
#close    xscale = function(x) (x - mx[1]) * mx[2]/(orig[2] - mx[1]) + 1
    xscale = function(x) (x - mx[1]) * mx[2]/(orig[2] - mx[1]) + 1    
#    yscale = function(y) (y - my[1])* mx[1]/(orig[1] - my[1])
    # The y's are upside down.
    yscale = function(y) (y - my[1])* my[2]/(orig[1] - my[1]) + 1
#    yscale = function(y) (y - my[1]) * r/(diff(my))

    m[,1] = xscale(m[,1])
    m[,3] = xscale(m[,3])

    m[,2] = yscale(m[,2])
    m[,4] = yscale(m[,4])
    
} else {  # show whole image
    r = nrow(img)
    c = ncol(img)
}
    
    plot(0, type = "n", xlab = "", ylab = "", xlim = c(0, c), ylim = c(0, r), ...)
    
    if(!is.null(img) && !is.na(img))
       rasterImage(img, 0, 0, c, r)
     # Draw the bounding boxes for the detected elements.
    rect(m[,1], r - m[,2], m[,3], r - m[,4], border = border)
     # And now the outer containing rectangle enclosing all the bounding boxes
    rect(min(m[,1]), r - min(m[,2]), max(m[,3]), r - max(m[,4]), border = outer.border)

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
