getLines =
    # Could reuse all the pixmaps
function(pix, hor, vert, asLines = TRUE, invert = !asLines)
{
   p3 = pixCloseGray(pix, hor, vert)
   p4 = pixErodeGray(p3, 3, 5)

   p5 = pixThresholdToValue(p4, 210, 255)
   p6 = pixThresholdToValue(p5, 210, 0)

   # We don't use this again in these computations, but we want it to get the actual lines.
   if(asLines) {
       tmp = pixThresholdToBinary(p6, 210)
       if(invert)
          tmp = pixInvert(tmp)
       return(tmp)
   }
   
   if(invert)
       pixInvert(p6)
   else
       p6
}
