mkPages =
    #
    # Could use number of pages to determine the fmt but Rtesseract doesn't itself have the
    # ability to compute this from the PDF file.
    #
function(filename, dir = dirname(filename), fmt = "_p%04d.png", density = 300, cmd = pdf2png())
{
    base = tools::file_path_sans_ext(basename(filename))
    out = paste0(file.path(dir, base), fmt)
    system2(cmd, c("-d", density, "-o", out, filename))
    pat = sprintf("%s_p[0-9]+\\.png$", base) # ...
    list.files(dir, pattern = pat, full.names = TRUE)
}

pdf2png =
function()    
{
    getOption("PDF2PNG", system.file("bin/pdf2png", package = "Rtesseract"))
}
