
# render the results as a searchable PDF but using R's graphics.
# ts = tesseract(system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract"))
# render(b, getImageDims(ts)[2:1], cex = .5)
#
render =
function(bbox, dims = c(max(bbox[,c(1, 3)], min(bbox[,c(2, 4)]))), cex = 1, ...)
{
    opar = par(no.readonly = TRUE)
    on.exit(par(opar))
    
    par(mar = c(0, 0, 0, 0))


    nrow = dims[2]    
         # put the y's going from bottom to top, unlike their originals which are top to bottom.
    bbox[,2] = nrow - bbox[,2]
    bbox[,4] = nrow - bbox[,4]

    x = (bbox[,1] + bbox[,3])/2
    y = (bbox[,2] + bbox[,4])/2
    x = bbox[,3] 
    y = bbox[,2] 

    plot(0, type = "n", axes = FALSE, xlim = c(0, dims[1]), ylim = c(0, dims[2]), xlab = "", ylab = "", ...)
    box()
    
    text(x, y, rownames(bbox), cex = cex) # , adj = c(.5, .5))
}
