#include "Rtesseract.h"


#if 0
extern "C"
SEXP
R_TessBaseAPI_(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }


  return(R_NilValue);
}
#else
enum {A};
#endif


