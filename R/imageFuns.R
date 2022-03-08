if(FALSE)
    # Old version that just uses the extension.
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

readImage =
    # Version that reads the format from the header of the file.
function(filename, format = names(readImageInfo(filename)$format))
{
    format = tolower(format)
    
    if(grepl("png", format))
        img = png::readPNG(filename)
    if(grepl("jpeg|jp2", format))
        img = jpeg::readJPEG(filename)
    if(grepl("tiff", format))
        img = tiff::readTIFF(filename)
    img
}

