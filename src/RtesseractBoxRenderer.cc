#include "Rtesseract.h"
#include "RtesseractBoxRenderer.h"


bool 
RTessBoxTextRenderer::BeginDocument(const char* title)
{
    Rprintf("Starting document\n");
    return true;
}

bool RTessBoxTextRenderer::AddImageHandler(tesseract::TessBaseAPI* api)
{
    Rprintf("AddImageHandler\n");
    return(true);
}

bool RTessBoxTextRenderer::AddImage(tesseract::TessBaseAPI* api)
{
    Rprintf("AddImage\n");
    return(true);
}


void RTessBoxTextRenderer::AppendString(const char* s) {

    Rprintf("AppendString %s\n", s);
    if(!ans) {
        PROTECT(ans = NEW_CHARACTER(5));
        nprotect++;
    } else if(count == Rf_length(ans)) {
        PROTECT(SET_LENGTH(ans, Rf_length(ans) * 2));
        nprotect++;
    }
    
    SET_STRING_ELT(ans, count++, mkChar(s));
    Rf_PrintValue(ans);
}




