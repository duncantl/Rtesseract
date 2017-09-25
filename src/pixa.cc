#include <tesseract/osdetect.h>
#include "Rtesseract.h"


SEXP BoxaAToR(Boxa *boxes);
SEXP PixaAToR(Pixa *pixes);
SEXP retPixaBoxa(Pixa *pix, Boxa *boxes);

extern "C"
SEXP
R_TessBaseAPI_GetRegions(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  Boxa *boxes;
  Pixa *pix;
  boxes = api->GetRegions(&pix);
  if(!boxes || !pix)
      return(R_NilValue);

//  Rprintf("n: %d, %d\n", pix->n, boxes->n);

  return(retPixaBoxa(pix, boxes));  
}



extern "C"
SEXP
R_TessBaseAPI_GetStrips(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  Boxa *boxes;
  Pixa *pix;
  boxes = api->GetStrips(&pix, NULL);
  if(!boxes || !pix)
      return(R_NilValue);

//  Rprintf("n: %d, %d\n", pix->n, boxes->n);

  return(retPixaBoxa(pix, boxes));
}

SEXP
BoxaAToR(Boxa *boxes)
{
  int n = boxes->n;
  SEXP bans = NEW_INTEGER(n*4);
  for(int i = 0; i < n ; i++) {
      INTEGER(bans)[ i ] = boxes->box[i]->x;
      INTEGER(bans)[ i + n ] = boxes->box[i]->y;      
      INTEGER(bans)[ i + 2*n ] = boxes->box[i]->w;
      INTEGER(bans)[ i + 3*n ] = boxes->box[i]->h;               
  }
  return(bans);
}

SEXP
PixaAToR(Pixa *pixes)
{
    int n = pixes->n, i = 0;
    SEXP ans, tmp;
    double *w, *h, *d, *spp, *wpl;
    int *xres, *yres, *informat, *special;
    
    PROTECT(ans = NEW_LIST(10));
    SET_VECTOR_ELT(ans, i++, tmp = NEW_NUMERIC(n)); w = REAL(tmp);
    SET_VECTOR_ELT(ans, i++, tmp = NEW_NUMERIC(n)); h = REAL(tmp);
    SET_VECTOR_ELT(ans, i++, tmp = NEW_NUMERIC(n)); d = REAL(tmp);
    SET_VECTOR_ELT(ans, i++, tmp = NEW_NUMERIC(n)); spp = REAL(tmp);
    SET_VECTOR_ELT(ans, i++, tmp = NEW_NUMERIC(n)); wpl = REAL(tmp);
    SET_VECTOR_ELT(ans, i++, tmp = NEW_INTEGER(n)); xres = INTEGER(tmp);
    SET_VECTOR_ELT(ans, i++, tmp = NEW_INTEGER(n)); yres = INTEGER(tmp);
    SET_VECTOR_ELT(ans, i++, tmp = NEW_INTEGER(n)); informat = INTEGER(tmp);
    SET_VECTOR_ELT(ans, i++, tmp = NEW_INTEGER(n)); special = INTEGER(tmp);
    SET_VECTOR_ELT(ans, i++, tmp = NEW_CHARACTER(n));
    
    
    for(i = 0; i < n ; i++) {
        w[i] = pixes->pix[i]->w;
        h[i] = pixes->pix[i]->h;
        d[i] = pixes->pix[i]->d;
        spp[i] = pixes->pix[i]->spp;
        wpl[i] = pixes->pix[i]->wpl;
        xres[i] = pixes->pix[i]->xres;
        yres[i] = pixes->pix[i]->yres;
        informat[i] = pixes->pix[i]->informat;
        special[i] = pixes->pix[i]->special;
        SET_STRING_ELT(tmp, i, mkChar(pixes->pix[i]->text ? pixes->pix[i]->text : ""));
    }
    
    UNPROTECT(1);
    return(ans);
}


SEXP
retPixaBoxa(Pixa *pix, Boxa *boxes)
{
  SEXP ans;
  PROTECT(ans = NEW_LIST(2));
  SET_VECTOR_ELT(ans, 0, BoxaAToR(boxes));
  SET_VECTOR_ELT(ans, 1, PixaAToR(pix));  
  UNPROTECT(1);
  return(ans);
}


