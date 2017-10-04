getLines =
function(pix, lineThreshold = .1, hor, vert, ..., asIs = is(pix, "AsIs"))
{
  if(!asIs)
     pix = findLines(pix, hor, vert, ...)

  img = pixGetPixels(pix)
  horizontal = hor > vert
  r = if(horizontal) 
         rowSums(img)
      else
         colSums(img)

  if(lineThreshold < 1)
      lineThreshold = lineThreshold * if(horizontal) nrow(img) else ncol(img)

  w = r > lineThreshold
  
}

findLines =
    # Could reuse all the pixmaps
function(pix, hor, vert, asLines = TRUE, invert = !asLines, erode = c(3, 5), threshold = 210)
{
    p3 = pixCloseGray(pix, hor, vert)
    if(length(erode))
       p3 = pixErodeGray(p3, erode[1], erode[2])

   p5 = pixThresholdToValue(p3, threshold, 255)
   p6 = pixThresholdToValue(p5, threshold, 0)

   # We don't use this again in these computations, but we want it to get the actual lines.
   if(asLines) {
       tmp = pixThresholdToBinary(p6, threshold)
       if(invert)
          tmp = pixInvert(tmp)
       return(tmp)
   }
   
   if(invert)
      pixInvert(p6)
   else
      p6
}
