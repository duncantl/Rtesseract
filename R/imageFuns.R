readImage =
function(filename)
{
    if(grepl("\\.png$", filename))
        img = png::readPNG(filename)
    if(grepl("\\.je?pg$", filename))
        img = jpeg::readJPEG(filename)
    if(grepl("\\.tiff?$", filename))
        img = tiff::readTIFF(filename)
    img
}

