
#include "Rtesseract.h"

SEXP
getPixAsArray(const Pix *pix)
{
    l_uint32 numEls = pix->w * pix->h * pix->d/8; // depth is in bits.
    SEXP ans;
    PROTECT(ans = NEW_NUMERIC(numEls));
    double *rels = REAL(ans);
    for(int i = 0; i < numEls; i++)
        rels[i] = pix->data[i];

    SEXP dims = NEW_INTEGER(3);
    PROTECT(dims);
    INTEGER(dims)[0] = pix->h;
    INTEGER(dims)[1] = pix->w;
    INTEGER(dims)[2] = pix->d/8;

    SET_DIM(ans, dims);
    
    UNPROTECT(2);
    return(ans);
}


extern "C"
SEXP
R_pixWrite(SEXP r_pix, SEXP r_file, SEXP r_format)
{
    Pix *pix = GET_REF(r_pix, Pix);
    int ans = pixWrite(CHAR(STRING_ELT(r_file, 0)), pix, (l_int32) INTEGER(r_format)[0]);
    return(ScalarInteger(ans));
}




extern "C"
SEXP
R_getImagelibVersions()
{
    char *x = getImagelibVersions();
    return(ScalarString(Rf_mkChar(x ? x : "")));
}


extern "C"
SEXP
R_getLeptonicaVersion()
{
    SEXP ans = NEW_INTEGER(3);
    INTEGER(ans)[0] = LIBLEPT_MAJOR_VERSION;
    INTEGER(ans)[1] = LIBLEPT_MINOR_VERSION;
    INTEGER(ans)[2] = LIBLEPT_PATCH_VERSION;
        
    return(ans);
}
