plot.OCRResults =
function(x, y, cex = .5, col = "black", xlim = range(c(x$left, x$right)) * c(.95, 1.05),
         #!!! instead of accessing imageDims[1], have an accessor function that returns NA
         # or something if not present.
         ylim = c(0, imageDims(x)["rows"]), # range(c(x$top, x$bottom))*c(.95, 1.05)
         ...)
{
    plot(0, type = "n", xlim = xlim, ylim = ylim, xlab = "", ylab = "", ...)

    h = max(ylim)
    text(x$left, h - x$bottom, x$text, adj = c(0, 0), cex = cex, col = col)
}

imageDims =
function(x, ...)
  UseMethod("imageDims")

imageDims.default =
function(x, ...)
{
    ans = attr(x, "imageDims")
    if(is.null(ans))
        c(rows = NA, columns = NA)
    else
        ans
}
setOldClass(c("OCRResults", "data.frame"))
setMethod("plot", "OCRResults", plot.OCRResults)

setMethod("[", "OCRResults",
          function(x, i, j, ...) {
              ans = callNextMethod()
              if(is.data.frame(ans))
                  class(ans) = class(x)
              ans
          })

showPoints =
function(x, top = par()$usr[4], radii = top*.05, fg = "red", inches = FALSE, addGuides = !inches, ...)
{
   x0 = (x$left + x$right)/2
   y0 = top - (x$top + x$bottom)/2
   radii = rep(radii, nrow(x))
   symbols(x0, y0, circles = radii, add = TRUE, fg = fg, inches = inches, ... )
   if(addGuides) {
       # draw dashed lines from the center
       ang = c(60, 150, 270)
#       ang = c(0, 180, 270)
 #      ang = c(90, 60, 270)       
       ang = 2*pi*ang/360
       
       x1 = rep(x0, each = 3)
       y1 = rep(y0, each = 3)
       x2 = x1 + radii[1]*cos(ang)
       y2 = y1 + radii[1]*sin(ang)

       xx = yy = rep(NA, (length(x0)+1)*3)
       i = seq(1, by = 3, length = (length(x0))*3)
#       browser()       
       xx[i] = x1
       yy[i] = y1
       xx[i+1] = x2
       yy[i+1] = y2       

       #  c(x0[1], x1[1] , NA,
       #    x0[1], x1[2] , NA,
       #    x0[1], x1[3], NA,
       #
       #    x0[2], x1[], NA
       
       lines(xx, yy, col = fg, lty = 3, ...)

     #  lines(c(x0[1], x0[1] + radii[1]), c(y0[1], y0[1]), col = "blue", lwd = 4)
   }
}


plot.SpellCheckedOCRResults =
function(x, y, cex = 1, col = c("red", "black")[x$SpelledCorrectly + 1L], ...)
{
   NextMethod("plot", cex = cex, col = col)
}


aspellCheck =
function(x, ...)
  UseMethod("aspell")


aspellCheck.OCRResults =
function(x, ...)    
{
    x$SpelledCorrectly = Aspell::aspell(x$text)
      # Make certain to keep x's original class so that this is still a data.frame.
    class(x) = c("SpellCheckedOCRResults", class(x))  # Should this be c("SpellChecked", "OCRResults")
    x
}
