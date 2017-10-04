plot.Pix =
    #
    # p = pixRead("inst/images/DifferentFonts.png")
    # p2 = pixConvertTo8(p)
    #
function(x, y, rgb = pixGetDepth(x) > 8, pixMax = max(pix), ...)   
{
    pix = if(rgb)
             pixGetRGBPixels(x)
          else
             pixGetPixels(x) # 

    pix[] = pix/pixMax

#    opar = par(no.readonly = TRUE)
#    on.exit(par(opar))
#    par(mar = c(2.1, 2.1, 4.1, 2.1))
    plot(0, type = "n", xlim = c(1, ncol(pix)), ylim = c(1, nrow(pix)), xlab = "", ylab = "", ...)
    rasterImage(pix, 1, 1, ncol(pix), nrow(pix))
}

setMethod("plot", "Pix", plot.Pix)

