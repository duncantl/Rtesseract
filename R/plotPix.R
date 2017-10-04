plot.Pix =
function(x, y , rgb = FALSE, ...)   
{
    pix = if(rgb)
             pixGetRGBPixels(x)
          else
             pixGetPixels(x) # 

    pix[] = pix/255
    # Have to normalize
#    browser()
    plot(0, xlim = c(1, ncol(pix)), ylim = c(1, nrow(pix)), ...)
    rasterImage(pix, 1, 1, ncol(pix), nrow(pix))
}
