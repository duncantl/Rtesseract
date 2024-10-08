
setAs("character", "Pix", function(from) pixRead(from))

pixAddGray =
function(pix1, pix2, target = NULL)
{
  .Call("R_pixAddGray", pix1, pix2, target)
}


pixThresholdToValue =
function(pix, threshold, newValue, target = NULL)
{
  .Call("R_pixThresholdToValue", pix, target, as.integer(threshold), as.integer(newValue))
}

pixThresholdToBinary =
function(pix, threshold, dims = GetImageDims(pix))
{
    if(dims[3] >  8)
       pix = pixConvertTo8(pix)
  .Call("R_pixThresholdToBinary", pix, as.integer(threshold))
}

pixInvert =
function(pix, target = NULL)
{
  .Call("R_pixInvert", pix, target)
}

pixConvertTo8 =
function(pix, colormap = FALSE)
{
  .Call("R_pixConvertTo8", pix, as.logical(colormap))
}

pixFindSkew =
function(pix)
{
  .Call("R_pixFindSkew", pix)
}


pixCloseGray =
function(pix, horiz, vert)
    .Call("R_pixCloseGray", pix, as.integer(horiz), as.integer(vert))

pixErodeGray =
function(pix, horiz, vert)
    .Call("R_pixErodeGray", pix, as.integer(horiz), as.integer(vert))

pixDilateGray =
function(pix, horiz, vert)
    .Call("R_pixDilateGray", pix, as.integer(horiz), as.integer(vert))

pixOpenGray =
function(pix, horiz, vert)
    .Call("R_pixOpenGray", pix, as.integer(horiz), as.integer(vert))


pixCloseBrick =
function(pix, horiz, vert, target = NULL)
    .Call("R_pixCloseBrick", pix, target, as.integer(horiz), as.integer(vert))

pixOpenBrick =
function(pix, horiz, vert, target = NULL)
    .Call("R_pixOpenBrick", pix, target, as.integer(horiz), as.integer(vert))

pixErodeBrick =
function(pix, horiz, vert, target = NULL)
    .Call("R_pixErodeBrick", pix, target, as.integer(horiz), as.integer(vert))

pixDilateBrick =
function(pix, horiz, vert, target = NULL)
    .Call("R_pixDilateBrick", pix, target, as.integer(horiz), as.integer(vert))


pixRotateAMGray =
    # AM = Area Mapping, i.e. interpolation. See docs in leptonica code.
function(pix, angle, grayVal = 0L)
    .Call("R_pixRotateAMGray", pix, as.numeric(angle), as.integer(grayVal))

pixRotate =
    # type - L_ROTATE_AREA_MAP
    # incolor  defaults to L_BRING_IN_WHITE. XXX Use this symbolic version.
function(pix, angle = -pi/2, type = 1L, incolor = 1L, width = 0L, height = 0L)
  .Call("R_pixRotate", pix, as.numeric(angle), as.integer(type), as.integer(incolor), as.integer(width), as.integer(height))


pixGetRes =
function(pix)
{    
   structure(.Call("R_pixGetRes", pix), names = c("rows", "columns"))
}

pixSetRes =
function(pix, h, v = h)
{
  res = as.integer(c(h, v))
  .Call("R_pixSetRes", pix, res)
}

pixGetDims =
function(pix)
{    
   structure(.Call("R_pixGetDims", pix), names = c("rows", "columns", "depth"))
}

pixGetPixels =
function(pix, dims = pixGetDims(pix), transpose = FALSE)
{
    ans = .Call("R_pixGetPixels", pix, as.logical(transpose))
    dim(ans) = if(transpose) rev(dims[1:2]) else dims[1:2]
    ans
}

pixGetRGBPixels =
function(pix, dims = pixGetDims(pix))
{
    ans = .Call("R_pixGetRGBPixels", pix)
    dims[3] = 3L
    dim(ans) = dims # [1:2]
    ans
}

pixSetPixels =
function(pix, vals, dims = pixGetDims(pix))
{
    dims = dims[1:2]
    if(!all(dims == dim(vals)))
        stop("dimensions are not equal to the image's dimensions")

    if(typeof(vals) != "integer") {
        tmp = as.integer(vals)
        attributes(tmp) = attributes(vals)
        vals = tmp
    }

    .Call("R_pixSetRGBPixels", pix, vals)
}


pixSubtract =
function(s1, s2, target = NULL)
{
   .Call("R_pixSubtract", s1, s2, target)
}

pixOr =
function(s1, s2, target = NULL)
{
   .Call("R_pixOr", s1, s2, target)
}

pixXor =
function(s1, s2, target = NULL)
{
   .Call("R_pixOr", s1, s2, target)
}

pixAnd =
function(s1, s2, target = NULL)
{
   .Call("R_pixAnd", s1, s2, target)
}


pixGetInputFormat =
function(pix, format)
{
   as(.Call("R_pixGetInputFormat", pix), "InputFileFormat")
}

pixClone =
function(pix)    
{
   .Call("R_pixClone", pix)
}

pixZero =
    # This does not zero the pixels in pix, but returns whether the pix is 'empty'
    # TRUE return indicates if all the values were 0
    #  meaning no black pixels in a binary image
    #  all pixels are black in a grayscale image
    #  all colors in all RGB pixels are 0.
function(pix)    
  .Call("R_pixZero", pix)

setMethod("[", c("Pix", "missing", "missing"),
          function(x, i, j, ...)  {
              pixGetPixels(x)
          })

setMethod("[", c("Pix", "numeric", "missing"),
          function(x, i, j, ...) {
              pixNumericSubset(x, i, seq(1, ncol(x)), ...)              
          })

    
setMethod("[", c("Pix", "missing", "numeric"),
          function(x, i, j, ...) {
              pixNumericSubset(x, seq(1, nrow(x)), j, ...)
          })


pixNumericSubset =
function(x, i, j, ...)
{
    d = dim(x)
    if(length(i) == 0)
        i = seq(1, d[1])
    else {
        i = as.integer(i)        
        if(any(i < 0))
            i = seq(1, d[1])[i]
    }

    if(length(j) == 0)
        j = seq(1, d[1])
    else {
        j = as.integer(j)    
        if(any(j < 0))
            j = seq(1, d[2])[j]
    }

    # Check for third dimension being requested via the ...
    # Could be specified x[i, j, k]  or missing but in query x[i, j, ]
    kall = match.call()
    if(!missing(...) || (length(kall) >= 5 && "" %in% setdiff(names(kall)[-1],  c("x", "i", "j")) && is.name(kall[[5]]) && kall[[5]] == "")) {
        tmp = pixGetRGBPixels(x)
        return(if(is.name(..1) && as.character(..1) == "")
                  tmp[i,j, ]
               else
                  tmp[i, j, ..1])
    }
    
    ans = .Call("R_pixGetSubsetPixels", x, i, j)

    dim(ans) = c(length(i), length(j))
    ans
}
setMethod("[", c("Pix", "numeric", "numeric"), pixNumericSubset)


setMethod("[", c("Pix", "logical", "logical"),
          function(x, i, j, ...) {
              ix = which(i)
              if(length(ix) == 0)
                  return(matrix(0, nrow(x), 0))
              
              jx = which(j)
              if(length(jx) == 0)
                  return(matrix(0, 0, ncol(x)))
              
              pixNumericSubset(x, ix, jx, ...)
        })
setMethod("[", c("Pix", "logical", "missing"),
          function(x, i, j, ...) {
              ix = which(i)
              if(length(ix) == 0)
                  return(matrix(0, nrow(x), 0))
              
              pixNumericSubset(x, ix, integer(), ...)              
        })

setMethod("[", c("Pix", "missing", "logical"),
          function(x, i, j, ...) {
              ij = which(j)
              if(length(ij) == 0)
                  return(matrix(0, 0, ncol(x)))
              
              pixNumericSubset(x, integer(), ij, ...)                            
        })

# Should do the cross over combinations, e.g., numeric, integer; numeric, logical
# no methods for character indexing.

setMethod("[", c("Pix", "matrix"),
          function(x, i, j, ...) {
            pixGetPixels(x)[ i, ... ]
          })

#??? Is this signature correct? Is it value that should be a matrix and i and j are missing.
setMethod("[<-", c("Pix", "matrix", "missing"),
          function(x, i, j, ..., value) {
              if(ncol(i) == 2) {
                  i = matrix(as.integer(i), , 2)
                  if(length(value) < nrow(i))
                     value = rep(value, length = nrow(i))

                  .Call("R_pixSet2DMatrixVals", x, i, value)
                  return(x)
              }

              stop('not implemented yet')
          })

setMethod("[<-", c("Pix", "missing", "numeric"),
          function(x, i, j, ..., value) {
              x[seq(1L, length = nrow(x)), j, ...] = value
              x
          })


tmp =
          function(x, i, j, ..., value) {
              i = as.integer(i)
              if(missing(j))
                  j = seq(1L, length = ncol(x))
              else
                  j = as.integer(j)
              
              # check for negative values.
              vals = as.integer(value)
              .Call("R_pixSetMatrixVals", x, i, j, vals)
              x
          }

setMethod("[<-", c("Pix", "numeric", "missing"), tmp)
setMethod("[<-", c("Pix", "numeric", "numeric"), tmp)


setMethod("[<-", c("Pix", "logical", "missing"),
          function(x, i, j, ..., value) {
              x[which(i), seq(1L, length = ncol(x))] = value
              x
          })

setMethod("[<-", c("Pix", "missing", "logical"),
          function(x, i, j, ..., value) {
              x[seq(1L, length = nrow(x)), which(j)] = value
              x
          })

setMethod("[<-", c("Pix", "logical", "logical"),
          function(x, i, j, ..., value) {
              x[which(i), which(j)] = value
              x
          })


if(!isGeneric("nrow"))
    setGeneric("nrow", function(x) standardGeneric("nrow"))

if(!isGeneric("ncol"))
    setGeneric("ncol", function(x) standardGeneric("ncol"))

setMethod("nrow", "Pix",
          function(x)
            pixGetDims(x)[1])

setMethod("ncol", "Pix",
          function(x)
          pixGetDims(x)[2])

setMethod("dim", "Pix",
          function(x)
            pixGetDims(x)[1:2])

pixGetDepth =
    # This doesn't call the C routine, but just accesses the value via the dimensions.
function(x)
 pixGetDims(x)[3]    


as.raster.Pix = as.raster.PIX =
function(x, rgb = pixGetDepth(x) > 8, maxPixel = NA, ...)    
{
    pixels = if(rgb)
                pixGetRGBPixels(x)
             else
                pixGetPixels(x)

    if(is.na(maxPixel))
        maxPixel = max(pixels)
    pixels[] = pixels/maxPixel
    pixels
}


pixEqual =
function(pix1, pix2, useAlpha = TRUE, useCMap = FALSE)
{
  .Call("R_pixEqual", pix1, pix2, as.logical(useAlpha), as.logical(useCMap))
}


pixFlipTB =
function(pix, target = NULL)
{
  .Call("R_pixFlipTB", pix, target)
}

pixFlipLR =
function(pix, target = NULL)
{
  .Call("R_pixFlipLR", pix, target)
}



setGeneric("pixCreate", function(x, ...)  standardGeneric("pixCreate"))
setMethod("pixCreate", "numeric",
          function(x, ...) {
              x = as.integer(x)
              if(length(x) < 3)
                 stop("Need width, height, and depth to create a Pix object")
              .Call("R_pixCreate", x)
          })

pixSetDims =
function(pix, width, height, depth, dims = c(width, height, depth))    
{
  .Call("R_pixSetDimensions", pix, as.integer(dims))
}




pixTranspose =
function(pix, vert = TRUE, horiz = FALSE)
{

      # Create a new pix with nrow, ncol being those flipped from pix
    d = GetImageDims(pix)
    p2 = pixCreate(d[c(2, 1, 3)])

    # Transpose the matrix and optionally reverse the order of each o the rows and the columns
      # get the pix as a matrix
#    m = pix[,]    
    m = pixGetPixels(pix, transpose = TRUE) # equivalent to t(m)
    if(horiz)
        m = m[, ncol(m):1]
    if(vert)
        m = m[nrow(m):1,]

      # Copy this matrix to the pix
    .Call("R_pixSetAllPixels", p2, dim(m), m)
    p2
}
