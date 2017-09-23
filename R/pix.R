GetStrips =
function(api)
{
    x = .Call("R_TessBaseAPI_GetStrips", api)
    mkBoxPix(x) 
}


GetRegions =
function(api)
{
    mkBoxPix( .Call("R_TessBaseAPI_GetRegions", api) )
}

mkBoxPix =
function(x)
{
   names(x) = c("box", "pix")
   x$box = matrix(x$box, , 4, dimnames = list(NULL, c("x", "y", "w", "h")))
   x$pix = as.data.frame(x$pix)
   names(x$pix) = c("w", "h", "d", "spp", "wpl", "xres", "yres", "informat", "special", "text")
   x
}
