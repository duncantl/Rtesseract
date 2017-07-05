toPDF =
function(imgFile, outFile = removeExtension(imgFile),
         renderer = PDFRenderer(outFile, GetDataPath(api), ...),
         api = tesseract(, PSM_AUTO), ...)
{
   renderPages(imgFile, api, renderer)
     # ensure the finalizer for the render object is run now.
     # This calls the C++ destructor (inherited one from TessResultRender) which flushes and closes the file.
   #rm(render); gc()
   gc()
   paste0(outFile, ".pdf")   
}

PDFRenderer =
function(outFile, datapath, textonly = FALSE)
{
   .Call("R_TessPDFRender", outFile, datapath, as.logical(textonly))
}

renderPages =
function(imgFile, api, render)
{    
    ok = .Call("R_TessBaseAPI_ProcessPages", api, imgFile, character(), 0L, render)
    if(!ok) 
        stop("Problem rendering page(s)")
    gc()
}

toTSV =
function(imgFile, fontInfo = TRUE, outFile = removeExtension(imgFile), api = tesseract(, PSM_AUTO))
{
   renderPages(imgFile, api, .Call("R_TessTsvRender", outFile, as.logical(fontInfo)))
   gc()
   paste0(outFile, ".tsv")
}

toHTML = toHOcr =
function(imgFile, fontInfo = TRUE, outFile = removeExtension(imgFile), api = tesseract(, PSM_AUTO))
{
   renderPages(imgFile, api, .Call("R_TessHOcrRender", outFile, as.logical(fontInfo)))
   gc()
   paste0(outFile, ".hocr")
}


toUNLV =
    # UNLV
function(imgFile, outFile = removeExtension(imgFile), api = tesseract(, PSM_AUTO))
{
   renderPages(imgFile, api, .Call("R_TessUnlvRender", outFile))
   gc()
   paste0(outFile, ".unlv")
}


toOSD =
    # OSD - orientation and script detection
function(imgFile, outFile = removeExtension(imgFile), api = tesseract(, PSM_AUTO))
{
   renderPages(imgFile, api, .Call("R_TessOsdRender", outFile))
   gc()
   paste0(outFile, ".osd")
}


toBoxText =
function(imgFile, outFile = removeExtension(imgFile), api = tesseract(, PSM_AUTO))
{
   renderPages(imgFile, api, .Call("R_TessBoxTextRender", outFile))
   gc()
   paste0(outFile, ".box")
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
