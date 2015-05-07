#include <tesseract/baseapi.h>
#include <Rdefines.h>


#define GET_REF(obj) \
   GET_SLOT(obj, Rf_install("ref"))

extern "C"
SEXP
R_TessBaseAPI_new()
{
  tesseract::TessBaseAPI *api = new tesseract::TessBaseAPI();
  SEXP ans, klass;
  PROTECT(klass = MAKE_CLASS("TessBaseAPI"));
  PROTECT(ans = NEW(klass));
  SET_SLOT(ans, Rf_install("ref"), R_MakeExternalPtr(api, Rf_install("TessBaseAPI"), R_NilValue));

  // Set finalizer to garbage collect when we let go/release this object.

  UNPROTECT(2);
  return(ans);
}

extern "C"
SEXP
R_TessBaseAPI_Init(SEXP r_api, SEXP r_lang)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }
  const char *lang = CHAR(STRING_ELT(r_lang, 0));
  int ok = api->Init(NULL, lang);
  return( ScalarLogical( ok == 0 ));
}

extern "C"
SEXP
R_TessBaseAPI_SetVariables(SEXP r_api, SEXP r_vars)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  SEXP r_optNames = GET_NAMES(r_vars);
  int i;
  for(i = 0; i < Rf_length(r_vars); i++) 
      api->SetVariable(CHAR(STRING_ELT(r_optNames, i)), CHAR(STRING_ELT(r_vars, i)));

  return( ScalarInteger( i ));
}


