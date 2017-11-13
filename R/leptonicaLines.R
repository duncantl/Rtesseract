getLines =
    # fi
    #
    # We could identify the margins and ignore those, i.e. those columns that have not black pixels.
    #  Doing this first may help.
    #
    #
    # 
function(pix, hor, vert, lineThreshold = .1, fraction = .5, gap = .02,
          ..., asIs = is(pix, "AsIs"), horizontal = hor > vert)
{
  if(!asIs)
     pix = findLines(pix, hor, vert, ...)

  img = pixGetPixels(pix)

  r = if(horizontal) 
         rowSums(img)
      else
         colSums(img)

  if(lineThreshold < 1)
      lineThreshold = lineThreshold * if(horizontal) ncol(img) else nrow(img)

  w = r > lineThreshold

  vecs = if(horizontal) img[w, ] else img[, w]

    # Group the rows/columns based on their indices
  idx = which(w)
  g = cumsum( diff(idx) > 2 )
    # collect the rows   Fix for columns too.
  ll = lapply(split(seq(along = idx), c(0, g)), function(i) if(horizontal) img[idx[i], ] else img[, idx[i]])
  names(ll) = pos = tapply(seq(along = idx), c(0, g), function(i) as.integer(mean(idx[i])))

    # Next, for each of these vectors, process the groups to find where they agree

  z = mapply(getHLine, ll, pos, MoreArgs = list(horizontal = horizontal, fraction = fraction, gap = gap), SIMPLIFY = FALSE)
}

getHLine =
    #  x is a matrix of (in the horizontal case) rows that are close together that make up a single line on the image but consist of multiple lines in the matrix.
    # fraction  proportion of the "rows" that have to have a black pixel for that column to be considered black/on
function(x, coord, horizontal = TRUE, fraction = .5, gap = .02)
{
    if(horizontal) {
        on = colSums(x) > nrow(x) * fraction
        if(gap < 1)
           gap = gap * ncol(x)
    } else {
        on = rowSums(x) > ncol(x) * fraction
        if(gap < 1)
           gap = gap * nrow(x)        
    }
    
    if(!any(on))
        return(matrix(0, , 2))
    
    r = rle(on)
    i = which(r$values)
    pos = cumsum(r$length)
    ans = cbind(pos[i-1], pos[i])
    ans = connectGap(ans, gap)

    m = matrix(0, nrow(ans), 4, dimnames = list(NULL, c("x0", "y0", "x1", "y1")))
    if(horizontal) {
        m[, c(1, 3)] = ans
        m[, c(2, 4)] = coord        
    } else {
        m[, c(2, 4)] = ans
        m[, c(1, 3)] = coord        
    }

    m
    
#    idx = sort(c(i-1,i))
#    matrix(cumsum(r$length)[idx],, 2, byrow = TRUE)
}

connectGap =
function(pos, gap)    
{
    d = pos[-1,1] - pos[-nrow(pos), 2]  < gap
    x = tapply(seq(1, nrow(pos)), c(0, cumsum(!d)), function(i) range(pos[i,]))
    matrix(unlist(x),, 2, byrow = TRUE)
}

findLines =
    # This returns a Pix object, either the one with the lines
    # or 
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
