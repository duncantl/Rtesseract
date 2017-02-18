
toPDF =
function(imgFile, outFile = removeExtension(imgFile),
         api = tesseract(, PSM_AUTO))
{
    render = .Call("R_TessPDFRender", outFile, GetDatapath(api))
    ok = .Call("R_TessBaseAPI_ProcessPages", api, imgFile, character(), 0L, render)
    if(!ok) {
        stop("Problem creating PDF file")
    }
     # ensure the finalizer for the render object is run now.
     # This calls the C++ destructor (inherited one from TessResultRender) which flushes and closes the file.
    rm(render)
    gc()
    
    outFile
}


removeExtension =
function(file)
  gsub("\\.[a-z]{,4}$", "", file)


# Not used.
changeExtension =
function(filename, ext)
{
    gsub("\\.[a-z]{,4}$", ext, filename)
}
