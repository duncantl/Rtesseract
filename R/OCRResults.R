plot.OCRResults =
function(x, y, cex = .5, col = "black", xlim = range(c(x$left, x$right)) * c(.95, 1.05),
          ylim = range(c(x$top, x$bottom))*c(.95, 1.05), ...)
{
    plot(0, type = "n", xlim = xlim, ylim = ylim, xlab = "", ylab = "", ...)

    h = max(ylim)
    text(x$left, h - x$bottom, x$text, adj = c(0, 0), cex = cex, col = col)
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
function(x, top = par()$usr[4], radii = 30, fg = "red", ...)
{
   radii = rep(radii, nrow(x))
   symbols((x$left + x$right)/2, top - (x$top + x$bottom)/2, circles = radii, add = TRUE, fg = fg, ... )
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
