# Collection of tests for Tesseract 4.00

library(Rtesseract)
library(png)

# Confirm 4.00
if(tesseractVersion() == "4.00"){

    f = system.file("images", "DifferentFonts.png", package = "Rtesseract")
    
    api = tesseract(f, pageSegMode = 6)
    GetText(api)
    
    # Test for LSTM
    api = tesseract(f, engineMode = "OEM_CUBE_ONLY")
    GetText(api)                            # no segfault

    api = tesseract(f, engineMode = "LSTM")
    GetText(api)                            # no segfault

    

}
