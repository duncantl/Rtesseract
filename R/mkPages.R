mkPages =
    #
    # Could use number of pages to determine the fmt but Rtesseract doesn't itself have the
    # ability to compute this from the PDF file.
    #
function(filename, dir = dirname(filename), fmt = "_p%04d.png", density = 300, cmd = pdf2png())
{
    base = tools::file_path_sans_ext(basename(filename))
    out = paste0(file.path(dir, base), fmt)
    system2(cmd, c("-d", density, "-o", shQuote(out), shQuote(filename)))


    # Can get the relevant components - prefix, extension and replace the %... with [0-9]
    # Or more simply can just replace the %[0-9]+d with [0-9]+
    # And escape any .'s
    #
    pat0 = gsub("\\.", "\\\\.", gsub("%[0-9]+d", "[0-9]+", fmt))
    pat = paste0(base, pat0) # "%s%s", base) 
    list.files(dir, pattern = pat, full.names = TRUE)
}

pdf2png =
function()    
{
    getOption("PDF2PNG", system.file("bin/pdf2png", package = "Rtesseract"))
}
