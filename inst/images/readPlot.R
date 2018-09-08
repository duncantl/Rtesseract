if(FALSE) {

    # examples - West\ Causcasian\ Bat\ Virus/Wright-2010.pdf
    #            Mucambo\ Virus/Auguste-2010.pdf
    #  See Auguste-2010.jpg
    # Doggett-1999
    # Yasuda-2012.xml
    # Moore-2007
    # Kuzmin-2008
    # Yasuda-2012
    # Prescot-2013
    # "../Lagos Bat Virus/Malerczyk-2014.xml"
    # Hayman-2010
    
    # See ReadPDF/inst/examples/readPlot.R
    library(Rtesseract)
    f = "scatterplot.png"    
    ts = tesseract(f)
    bb = GetBoxes(ts)
    # Need to rotate a subregion of the image to get the
    # rotated text on the vertical axis.

    tsv = tesseract(f, 
                    textord_tabfind_vertical_text = 1,
                    textord_tabfind_force_vertical_text = 1)
    pix = GetImage(tsv)
    SetRectangle(tsv, 0, 0, 57, nrow(pix))
    bbr = GetBoxes(tsv)
    
    
    pix = GetImage(ts)
    l = pix[, 1:57]

    pix = GetImage(ts)
    pr = pixRotate(pix, -pi/2)
    plot(pr)

    
    # Flip the image (different from rotating which leaves the dimension unaltered)
    pr = pixTranspose(pixTranspose(pixTranspose(pix)))
    tsr = tesseract(pr)
    SetRectangle(tsr, 0, 0, 900, 100)
    bbr = GetBoxes(tsr)


    # Get the plot region
    pix = pixRead(f)
    p1 = pixConvertTo8(pix)
    hl = getLines(p1,  30, 1)
    vl = getLines(p1,  1, 30)

    plot(pix)
    lapply(hl, function(x) lines(x[1, c(1, 3)], nrow(pix) - x[1, c(2, 4)], col = "red"))
    lapply(vl, function(x) lines(x[1, c(1, 3)], nrow(pix) - x[1, c(2, 4)], col = "red"))


    # Find the tick lines.
    # These may be too small.

    # ticks
    thl = getLines(p1,  2, 1)    
}



if(FALSE) {
    au = pixRead("Auguste-2010.jpg")
    ar = getPlotRegion(au, combine = FALSE)
    
    plot(au)
    abline(h = nrow(au) - ar$h$y0, col = "red")
    abline(v = ar$v$x0, col = "red")    
    
    bb = GetBoxes(au)

    w = bb$left <= min(ar$v$x0)
    bb[w, ]
    v1 = split(bb[w, ], cut(bb$left[w], 2))
    vlabels = v1[[2]]

    data.frame(raw = (vlabels$top + vlabels$bottom)/2, values = as.numeric(vlabels$text))
    # So now we can map pixels to values on the y axis

    # This plot has a second axis
    w = bb$left >= max(ar$v$x0)
    bb[w, ]
    v2 = split(bb[w, ], cut(bb$left[w], 2))
    vlabels2 = v2[[1]]

    # We don't get the 20 and 10 correct - 1) and I" respectively.
    # But we only need two points to compute the scaling function.

      # keep the text since converting to numbers makes 2 NAs.
    data.frame(raw = (vlabels2$top + vlabels2$bottom)/2, values = as.numeric(vlabels2$text), text = vlabels2$text)

    # Now get the horizontal labels.
    # We "rotate" the image by transposing it 3 times.
    v = pixTranspose(pixTranspose(pixTranspose(au)))
    bbv = GetBoxes(v)

    #
    ax = min(nrow(au) - ar$h$y0)
    plot(v)
    abline(v = ax, col = "red")

    w = bbv$left < ax - 10  # -10 to avoid any items starting very close to the line. we want the labels starting further to the left.
    bbv[w,]
    tmp = split(bbv[w,], cut(bbv$left[w], 2))

    xlabels = tmp[[2]]
    # We get some errors in the text since the points (rectangles, triangles)
    # are not clipped and extend over the

    # We can fix these using contextual information
    xlabels = xlabels[ grep("-", xlabels$text), ]
    xlabels[nchar(xlabels$text) != 5, ]

    xlabels$text = substring(xlabels$text, 1, 5)
    xlabels[nchar(xlabels$text) != 5, ]
    # just one 09-0.   We can add the 7 or determine it because it is between -07 values.
    w = nchar(xlabels$text) != 5
    xlabels$text[w] = paste0(xlabels$text[w], "7")

    # now get the axis labels for the two vertical axes since we have now rotated the text.
    # We know these are the top and bottom lines of text.
    # The number 12 comes from 12pt. It is somewhat arbitrary, so we could do this more
    # robustly. We could look above and below the plot region and ignoring the tick labels.
    tmp = split(bbv$text, cut(bbv$top, seq(0, max(bbv$top + 12), by = 12)))
    tmp = tmp[sapply(tmp, length) > 0]
    yAxisLabels = sapply(tmp[ c(1, length(tmp))], paste, collapse = " ")

    # Now let's also get the xaxis label (Month)
    tmp = split(bb$text,  cut(bb$top, c(0, max(bb$top) - 20, Inf)))    
    xAxisLabel = paste(tmp[[length(tmp)]], collapse = " ")

    # How do we get the points. The OCR doesn't recognize them.

    hw = bb$left > min(ar$v$x0) & bb$right < max(ar$v$x0)
    hv = bb$top > min(ar$h$y0) & bb$bottom < max(ar$h$y0)
    # bb doesn't have the x tick marks since they are not horizontal text.

    w = hw & hv
    table(w) # 46 true
    pts = bb[w,]

    plot(au)
    points((pts$left + pts$right)/2, nrow(au) - (pts$top + pts$bottom)/2, col = "red",pch = 22)

    # The points are related to the dashed line.
    # We will need non-OCR approaches.
}


if(FALSE) {

    f = "Vincent-2000.png"
    pix = pixRead(f)
    bb = GetBoxes(pix)
    pix8 = pixConvertTo8(pix)
    vl = getLines(pix8, 3, 11)    
    hl = getLines(pix8, 11, 3)

    plot(pix)
    apply(do.call(rbind, hl), 1, function(x) lines(x[c(1,3)], nrow(pix) - x[c(2,4)], col = "red"))
    # Miss 9 horizontal lines in the dendogram, and got some extras in the words.
    # Some are too long because they go into the words, e..g center of the B.
    # But we can truncate lines by any text at the same vertical level.
    
    apply(do.call(rbind, vl), 1, function(x) lines(x[c(1,3)], nrow(pix) - x[c(2,4)], col = "red"))
    # Miss 3 vertical lines and some in words.

}    

if(FALSE) {

    f = "Gao-2010_barchart.jpg"
    pix = pixRead(f)
    bb = GetBoxes(pix)
    pr = getPlotRegion(pix, combine = FALSE)

    b = max(pr$h$y0)
    bb[bb$bottom > b & bb$left > min(pr$v$x0), ]


     # The vertical axis
    lf = bb[ bb$left < min(pr$v$x0), ]
    xticks = split(lf$text, cut(lf$left, 2))
    
    # Now find the data points which are the heights of the bars.

    pix8 = pixConvertTo8(pix)
    vl = getLines(pix8, 15, 25, asDataFrame = TRUE)
    points(vl$x0, nrow(pix) - vl$y0, pch = "X", col = "blue")

    # We get the taller bars, but nothing below these.
    # If we change the height from 25 to, say, 10 we get even fewer - only 2.
    #

    # Let's find the bars
    # The gap between two adjacent bars is about 24 to 27.
    min(diff(vl$x0))    
    pixb = pixThresholdToBinary(pix8, 200)


    # Approaches to finding the bars is
    #   1)  use the mid points of the points we found via (vl$x0 + vl$x1)/2 and find the smallest difference between them
    #       Then all the points should be at regular intervals. (This assumes there are two adjacent time periods with values in the plot.
    #   2)  Move up k "pixels" in the image from horizontal axis line and look at that row  We will see the white pixels grouped with black pixels in between.
    #
    # Black is 0, white is 1.
    #
    #
    k = 6
    plot(pixb)
    abline(h = nrow(pixb) - (pr$h$y0 - k), col = "red")
    cols = as.integer(pixb[(pr$h$y0 - k), -(1:117)])
    
    tmp = cumsum(c(0, diff(cols)) != 0)
    xx = split(seq(along = cols), tmp)
    w = sapply(xx, length) > 12 & sapply(xx, function(x) cols[x[1]]) == 1
    pos = floor(sapply(xx[w], mean) + 118)
    abline(v = pos, col = "red")

    # So now we get the heights at each mid point.
    # We get the column from 1 to the location of the
    # Recall that the rows in the images go from top to bottom
    vals = sapply(pos, function(i) which(pixb[pr$h$y0:1, i]  == 0)[1])
    
    plot(vals, type = "h")
}


getPlotRegion =
function(pix, length = dim(pix)*threshold, combine = TRUE, threshold = .5, p8 = pixConvertTo8(pix))
{
    if(missing(length)) {
      # ensure odd
        e = as.integer(length)%%2 == 0
        length[e] = length[e] - 1
    }
    
    if(length(length) == 1)
        length = rep(length, 2)
    
    hl = getLines(p8, length[2], 1, asDataFrame = TRUE)
    vl = getLines(p8, 1, length[1], asDataFrame = TRUE)
    
    if(combine) {
        ans = rbind(hl, vl)
        ans$orientation = rep(c("horizontal", "vertical"), c(nrow(hl), nrow(vl)))
        ans
    } else
       list(horizontal = hl, vertical = vl)
}


getLabels =
function(img, bbox = GetBoxes(img), plotRegion = getPlotRegion(img))
{

}
