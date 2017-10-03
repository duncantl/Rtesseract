setClass("PIX", contains = "Pix")

setAs("character", "PIX", function(from) readPix(from))

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
function(pix, threshold)
{
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
    .Call("R_pixCloseGray", pix, as.integer(horiz), as.integer(vert))


pixRotateAMGray =
function(pix, angle, grayVal = 0L)
  .Call("R_pixRotateAMGray", pix, as.numeric(angle), as.integer(grayVal))


pixGetRes =
function(pix)
{    
   structure(.Call("R_pixGetRes", pix), names = c("rows", "columns"))
}

pixGetDims =
function(pix)
{    
   structure(.Call("R_pixGetDims", pix), names = c("rows", "columns", "depth"))
}

pixGetPixels =
function(pix, dims = pixGetDims(pix))
{
    ans = .Call("R_pixGetPixels", pix)
    dim(ans) = dims[1:2]
    ans
}

pixGetRGBPixels =
function(pix, dims = pixGetDims(pix))
{
    ans = .Call("R_pixGetPixels", pix)
    dim(ans) = dims[1:2]
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
