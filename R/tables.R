
findColumns =
function(api, bbox = getBoxes(api, level = level), level = 3)
{

    qleft = quantile(bbox[, "left"], seq(0, 1, by = .1))
    qright = quantile(bbox[, "right"], seq(0, 1, by = .1))    
    return(data.frame(qleft = qleft, qright = qright))
}
