if(FALSE){
findColumns =
function(api, bbox = GetBoxes(api, level = level), level = 3)
{

    qleft = quantile(bbox[, "left"], seq(0, 1, by = .1))
    qright = quantile(bbox[, "right"], seq(0, 1, by = .1))    
    return(data.frame(qleft = qleft, qright = qright))
}
}


findColumns =
function(api, bbox = GetBoxes(api, level = level), level = 3, ncols, side = "left")
{
    dens <- density(bbox[,side], adjust = 0.001)
    i <- order(dens$y, decreasing = TRUE)
    dens$x[i][1:ncols]
}
