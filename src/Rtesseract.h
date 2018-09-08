#ifndef RTESSERACT_H
#define RTESSERACT_H

#include <string>
//typedef std::string string;
using std::string;

#ifndef ADD_TESSERACT_DIR 
#include <baseapi.h> 
#else
#include <tesseract/baseapi.h> 
#endif

#include <allheaders.h>

using namespace std;
#include <Rdefines.h>


void R_pixDestroy(SEXP obj);


#define GET_REF(obj, type) \
  (type *) R_ExternalPtrAddr(GET_SLOT(obj, Rf_install("ref")))

SEXP createRef(void *ptr, const char * const classname, R_CFinalizer_t fin);
void R_freeAPI(SEXP obj);
void R_freeResultIterator(SEXP obj);


SEXP Renum_convert_PageSegMode(tesseract::PageSegMode val);

SEXP getPixAsArray(const Pix *pix);

#define CHECK_RECOGNIZE \
   if(!api->GetIterator()) api->Recognize();


SEXP getAllAlternatives(tesseract::TessBaseAPI *api, tesseract::PageIteratorLevel level);
//SEXP getAllAlternatives(tesseract::ResultIterator *ri, tesseract::PageIteratorLevel level);

#endif

