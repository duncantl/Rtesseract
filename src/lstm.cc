/* https://tesseract-ocr.github.io/tessdoc/APIExample.html */

#include "Rtesseract.h"

extern "C"
SEXP
R_getLSTMSymbolChoices(SEXP r_api, SEXP r_level)
{
    SEXP r_ans = R_NilValue;
    
    tesseract::TessBaseAPI *api = GET_REF(r_api, tesseract::TessBaseAPI);
    
    tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0]; // tesseract::RIL_WORD;
    tesseract::ResultIterator* res_it = api->GetIterator();
    
// Get confidence level for alternative symbol choices. Code is based on
// https://github.com/tesseract-ocr/tesseract/blob/a7a729f6c315e751764b72ea945da961638effc5/src/api/hocrrenderer.cpp#L325-L344

    std::vector<std::vector<std::pair<const char*, float>>>* choiceMap = nullptr;
    if (res_it != 0) {

        size_t nels = 1, idx = 0;
        while(res_it->Next(level)) nels++;

        PROTECT(r_ans = NEW_LIST(nels));
        
        res_it->Begin();
        
        do {
//            const char* word;
//            float conf;
//            int  tcnt = 1, gcnt = 1, wcnt = 0;
            int x1, y1, x2, y2;
            res_it->BoundingBox(level, &x1, &y1, &x2, &y2);
            
            choiceMap = res_it->GetBestLSTMSymbolChoices();

            size_t n = 0;
            for (auto timestep0 : *choiceMap)
                n += timestep0.size() > 0;

            choiceMap = res_it->GetBestLSTMSymbolChoices();

            SEXP rword;
            PROTECT(rword = NEW_LIST(n));
            n = 0;

            for (auto timestep : *choiceMap) {
                if (timestep.size() > 0) {
                    int i = 0;
                    for (auto & j : timestep)
                        i++;
                        

                    SEXP rconf, vals;
                    PROTECT(rconf = NEW_NUMERIC(i));
                    PROTECT(vals = NEW_CHARACTER(i));
                    i = 0;                        

                    for (auto & j : timestep) {

                        SET_STRING_ELT(vals, i, mkChar(j.first));
                        REAL(rconf)[i++] = j.second * 100;
/*
                        conf = int(j.second * 100);
                        word =  j.first;
                        printf("%d  symbol: '%s';  \tconf: %.2f; BoundingBox: %d,%d,%d,%d;\n",
                               wcnt, word, conf, x1, y1, x2, y2);
                        gcnt++;
*/                        
                    }
//                    tcnt++;

                    SET_NAMES(rconf, vals);
                    SET_VECTOR_ELT(rword, n++, rconf);
                    UNPROTECT(2);
                }
//                wcnt++;
//                printf("\n");
            }


            SET_VECTOR_ELT(r_ans, idx++, rword);
            UNPROTECT(1);
            
        } while (res_it->Next(level));
    }

    UNPROTECT(1);
    return(r_ans);
}
