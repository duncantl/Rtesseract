
readMultipageTiff =
function(file)
{
    if(!file.exists(file))
        stop("No such file")

    file = path.expand(file)

    structure(.Call("R_Leptonica_readMultipageTiff", file), class = "ListOfPix")
}

readImageInfo = readPixHeader =
function(file)
{
    if(!file.exists(file))
        stop("No such file")
    
    file = path.expand(file)
    ans = .Call("R_Leptonica_pixReadHeader", file)

    ans[[2]] = c(col = ans[[2]], row = ans[[3]])
    ans = ans[-3]

    ans[[1]] = as(ans[[1]], "ImageFormat")

    names(ans) = c("format", "dim", "bitsPerSample", "samplesPerPixel", "hasColormap")
    ans$hasColormap = as.logical(ans$hasColormap)
    
    ans
}
