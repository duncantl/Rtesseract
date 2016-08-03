#ifndef RTESSERACT_H
#define RTESSERACT_H

#include <baseapi.h>
#include <Rdefines.h>

#include <allheaders.h>

void R_pixDestroy(SEXP obj);


#define GET_REF(obj, type) \
  (type *) R_ExternalPtrAddr(GET_SLOT(obj, Rf_install("ref")))

SEXP createRef(void *ptr, const char * const classname, R_CFinalizer_t fin);
void R_freeAPI(SEXP obj);
void R_freeResultIterator(SEXP obj);


#endif

