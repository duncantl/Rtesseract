#include "Rtesseract.h"
#include "RtesseractBoxRenderer.h"



void RTessBoxTextRenderer::AppendString(const char* s) {

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



