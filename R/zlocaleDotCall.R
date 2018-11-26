if(tesseractVersion(runTime = FALSE) %in% c('4.00', '4.0')) {

.Call =
function (.NAME, ..., PACKAGE)
{
    #    old = Sys.getlocale()
    #    on.exit(Sys.setlocale(, old))
    old = getLocale()
    on.exit(resetLocale(old))    
#    Sys.setlocale(, "C")
    .C("Rtesseract_setCLocale", PACKAGE = "Rtesseract")
    base::.Call(.NAME, ..., PACKAGE = "Rtesseract")
}

LocaleEls = c("LC_COLLATE", "LC_CTYPE", "LC_MONETARY", "LC_NUMERIC", "LC_TIME", "LC_MESSAGES", "LC_PAPER", "LC_MEASUREMENT")

getLocale =
function()
{
#    cat("getLocale\n")
    tmp = sapply(LocaleEls, Sys.getlocale)
    tmp[tmp != ""]
}

resetLocale =
function(vals)
{
#    cat("resetLocale\n")
    mapply(Sys.setlocale, names(vals), vals)
}


} # end if (tesseractVersion()) 
