getOCRLines = getLines =
    # fi
    #
    # We could identify the margins and ignore those, i.e. those columns that have not black pixels.
    #  Doing this first may help.
    #
    #
    # 
function(pix,
         hor = dims[2]*.02,
         vert = 3, # was 5,
         lineThreshold = .1, fraction = .5, gap = .02, asDataFrame = FALSE,
         ..., asIs = is(pix, "AsIs"), horizontal = hor > vert, dims = dim(pix))
{
  pix = as(pix, "Pix")
    
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
  ll = lapply(split(seq(along = idx), c(0, g)), function(i) if(horizontal) img[idx[i], , drop = FALSE] else img[, idx[i], drop = FALSE])

  if(length(ll) == 0 || (length(ll) == 1 && nrow(ll[[1]]) == 0))
      return(NULL)
  
  names(ll) = pos = tapply(seq(along = idx), c(0, g), function(i) as.integer(mean(idx[i])))

    # Next, for each of these vectors, process the groups to find where they agree

  z = mapply(getHLine, ll, pos,
             MoreArgs = list(horizontal = horizontal, fraction = fraction, gap = gap),
             SIMPLIFY = FALSE)
  
  if(asDataFrame) {
      z = as.data.frame(do.call(rbind, z))
      z$stroke = "black"
      z$lineWidth = 1
      z$nodeType = "line"
      class(z) = c("DataFrameOfLineSegments", "ShapeBoundingBox", "data.frame")
  } else {
      class(z) = c("ListOfLineSegments", "list")  
  }

  class(z) = c(if(horizontal) "Horizontal" else "Vertical", class(z))
  z
}

setOldClass(c("DataFrameOfLineSegments", "ShapeBoundingBox", "data.frame"))
setOldClass(c("Horizontal", "DataFrameOfLineSegments"))
setOldClass(c("Vertical", "DataFrameOfLineSegments"))

lines.ListOfLineSegments =
function(x, top, col = "red", lty = 3, lwd = 2, ...)
{
  invisible(lapply(x,
             function(tmp) {
               lines(tmp[, c(1, 3)], top - tmp[, c(2, 4)], col = col,lty = lty, lwd = lwd, ...)
       }))    
}

setOldClass(c("ListOfLineSegments", "list"))
setMethod("plot", "ListOfLineSegments",
          plot.ListOfLineSegments <- function(x, y, pageHeight = max(sapply(x, function(x) max(x$y1))), ...) {
            lines(x, pageHeight, ...)
        })


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
        return(matrix(0, 0, 4, dimnames = list(NULL, c("x0", "y0", "x1", "y1" ))))

    if(!all(on)) {
        r = rle(on)
        i = which(r$values)
        if(length(i) > 1) {
            pos = cumsum(r$length)
               # if i contains 1, then i - 1 contains 0 and we will get unequal lengths in the cbind()
            ans = if(1 %in% i) cbind(pos[c(1, i[-1] -1)], pos[i]) else   cbind(pos[i-1], pos[i])
            ans = connectGap(ans, gap)
        } else
            ans = matrix(c(min(which(on)), max(which(on))), 1, 2)
    } else {
       ans = matrix(c(1, length(on)), 1, 2)
    }

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
    # or <....????>
function(pix, hor = dims[2]*.02,
         vert = 5, asLines = TRUE, invert = !asLines, erode = c(3, 5), threshold = 210,
         convertTo8 = GetImageDims(pix)[3] > 8, dims = dim(pix))
{
    pix = as(pix, "Pix")
    
    if(convertTo8)
       pix = pixConvertTo8(pix)
    
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
