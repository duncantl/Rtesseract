readImage =
function(filename)
{
    if(grepl("\\.png$", filename))
        png::readPNG(filename)
    if(grepl("\\.je?pg$", filename))
        jpeg::readJPEG(filename)
    if(grepl("\\.tiff?$", filename))
        rtiff::readTiff(filename)
}
