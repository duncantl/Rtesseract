.Call =
    #
    # This version intercepts all .Call()s in the package, and arranges to show any messages
    # tesseract created during the .Call() as a warning.
    #
function (.NAME, ..., PACKAGE)
{
   base::.Call("R_clear_tprintf")
   tryCatch(base::.Call(.NAME, ..., PACKAGE = "Rtesseract"),
#            error = function(e, ...) { browser()},
            finally = if(length(msg <- getTprintf())) warning(msg) )
}

getTprintf =
function()    
{
    els = base::.Call("R_get_tprintf")
    els = els[!(els %in% c("", "\\n"))]
    if(length(els) > 0) 
        paste(els, collapse = "")
    else
        character()
}
