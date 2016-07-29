
findColumns =
function(ri, bbox = BoundingBoxes(ri, level = level), level = "word")
{

    qleft = quantile(bbox[, "bottom.left.x"], seq(0, 1, by = .1))
    qright = quantile(bbox[, "top.right.x"], seq(0, 1, by = .1))    
    
}
