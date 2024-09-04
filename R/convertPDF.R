# Steps
# pdf2png the document
# get the list of images
# toPDF for each page
# combine the new PDFs into a single document.

cvtPDF =
function(pdf, out, pngs = listPNGs(pdf), ...)
{
#browser()    
    if(missing(pngs))
        pngs = Rtesseract:::mkPages(pdf, ...)

    pdfs = sapply(pngs, Rtesseract::toPDF)
    combinePDFs(pdfs, out)
}

listPNGs =
function(pdf)
{
    r = tools::file_path_sans_ext(basename(pdf))
    p = paste0(r, ".*[0-9]+\\.png$")
    list.files(dirname(pdf), pattern = p, full = TRUE)
}

combinePDFs =
function(pdfs, out)
{
    system2(qpdf(),
             c("--empty", "--pages", shQuote(pdfs), "--", shQuote(out)))

    # Add error handling.
    
    out
}

qpdf =
function()
{
   getOption("QPDF", "qpdf")
}


