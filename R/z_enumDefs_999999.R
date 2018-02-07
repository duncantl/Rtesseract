if(!exists("Orientation")) {
    tver = tesseractVersion(runTime = FALSE )    
    stop("We appear not to have generated the R-C enumeration definitions for your version of tesseract ", tver, ". Please contact the maintainers or alternatively modify the z_enumDefs_*.R file that most closely reflects your version to include your tesseract version string.")
}
