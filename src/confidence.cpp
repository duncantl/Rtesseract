/*
#include <baseapi.h>
#include <allheaders.h>

#include <Rdefines.h>
*/
#include "Rtesseract.h"


SEXP getAlternatives(tesseract::ResultIterator* ri, const char *word, float conf);
SEXP getRIConfidences(tesseract::PageIteratorLevel level, tesseract::TessBaseAPI *api);
SEXP getRIBoundingBoxes(tesseract::PageIteratorLevel level, tesseract::TessBaseAPI *api, SEXP r_names);


extern "C"
SEXP
R_ocr(SEXP filename, SEXP r_vars, SEXP r_level, SEXP r_collectorRoutines)
{
  SEXP ans = R_NilValue; 
  int i;

  tesseract::TessBaseAPI api; // = new tesseract::TessBaseAPI();
  if(api.Init(NULL, "eng")) {
    PROBLEM "could not intialize tesseract engine."	      
    ERROR;
  }
  Pix *image = pixRead(CHAR(STRING_ELT(filename, 0)));
  api.SetImage(image);

  SEXP r_optNames = GET_NAMES(r_vars);
  for(i = 0; i < Rf_length(r_vars); i++) 
      api.SetVariable(CHAR(STRING_ELT(r_optNames, i)), CHAR(STRING_ELT(r_vars, i)));


  api.Recognize(0);

  tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];  

  ans = getRIConfidences(level, &api);

  pixDestroy(&image);

  return(ans);
}


extern "C"
SEXP
R_ocr_boundingBoxes(SEXP filename, SEXP r_vars, SEXP r_level, SEXP r_names)
{
  SEXP ans = R_NilValue; 
  int i;

  tesseract::TessBaseAPI api; // = new tesseract::TessBaseAPI();
  if(api.Init(NULL, "eng")) {
     PROBLEM "could not intialize tesseract engine."	      
     ERROR;
  }
  Pix *image = pixRead(CHAR(STRING_ELT(filename, 0)));
  api.SetImage(image);

  SEXP r_optNames = GET_NAMES(r_vars);
  for(i = 0; i < Rf_length(r_vars); i++) 
      api.SetVariable(CHAR(STRING_ELT(r_optNames, i)), CHAR(STRING_ELT(r_vars, i)));


  api.Recognize(0);

  tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];  //RIL_WORD;

  ans = getRIBoundingBoxes(level, &api, r_names);

  pixDestroy(&image);

  return(ans);
}


/*
  Get the alternative predictions for each symbol.
 */
extern "C"
SEXP
R_ocr_alternatives(SEXP filename, SEXP r_vars, SEXP r_level)
{
  Pix *image = pixRead(CHAR(STRING_ELT(filename, 0)));
  int i;

  tesseract::TessBaseAPI api; // = new tesseract::TessBaseAPI();
  if(api.Init(NULL, "eng")) {
    PROBLEM "could not intialize tesseract engine."	      
    ERROR;
  }
  api.SetImage(image);

  SEXP r_optNames = GET_NAMES(r_vars);
  for(i = 0; i < Rf_length(r_vars); i++) 
      api.SetVariable(CHAR(STRING_ELT(r_optNames, i)), CHAR(STRING_ELT(r_vars, i)));

  api.Recognize(0);

  tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];

  SEXP ans = getAllAlternatives(&api, level);

  pixDestroy(&image);

  return(ans);
}

/******************************************/




extern "C"
SEXP
R_TesseractBaseAPI_getConfidences(SEXP r_api, SEXP r_level)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];  
  return(getRIConfidences(level, api));
}


SEXP
getRIConfidences(tesseract::PageIteratorLevel level, tesseract::TessBaseAPI *api)
{
  SEXP ans;

    int n = 1, i;
    tesseract::ResultIterator* ri = api->GetIterator();
    if(!ri) {
      api->Recognize(0);
      ri = api->GetIterator();
      if(!ri) {
          PROBLEM "cannot get ResultIterator"
          ERROR;
      }
    }

    while(ri->Next(level))   n++;

    delete ri; // XXX check

    ri = api->GetIterator();
    SEXP names;
    PROTECT(names = NEW_CHARACTER(n));
    PROTECT(ans = NEW_NUMERIC(n));
    i = 0;
    do {
      const char* word = ri->GetUTF8Text(level);
      float conf = ri->Confidence(level);

      SET_STRING_ELT(names, i, Rf_mkChar(word ? word : ""));
      REAL(ans)[i] = conf;
      delete[] word;
      i++;
    } while (ri->Next(level));

    delete ri; // XXX check

    SET_NAMES(ans, names);
    UNPROTECT(2);

  return(ans);
}


extern "C"
SEXP
R_getAllAlternatives(SEXP r_api, SEXP r_level)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];
    return(getAllAlternatives(api, level));
}


SEXP
getAllAlternatives(tesseract::TessBaseAPI *api, tesseract::PageIteratorLevel level)
{
  SEXP ans = R_NilValue; 
  int n = 1, i;
    tesseract::ResultIterator* ri = api->GetIterator();
    if(!ri) {
        PROBLEM "No ResultIterator. Have you called Recognize() on the tesseract object"
            ERROR;
    }
    while(ri->Next(level))
        n++;

    ri = api->GetIterator();
    SEXP names;
    PROTECT(names = NEW_CHARACTER(n));
    PROTECT(ans = NEW_LIST(n));
    i = 0;
    do {
      const char* word = ri->GetUTF8Text(level);
      float conf = ri->Confidence(level);
      SET_STRING_ELT(names, i, Rf_mkChar(word ? word : ""));
      SET_VECTOR_ELT(ans, i, getAlternatives(ri, word, conf));
      delete[] word;
      i++;
    } while (ri->Next(level));

    SET_NAMES(ans, names);
    UNPROTECT(2);

    return(ans);
}

SEXP
getAlternatives(tesseract::ResultIterator* ri, const char *word, float conf)
{
      tesseract::ChoiceIterator ci_r(*ri);
      int nels = 1; // was 2    ????
      while(ci_r.Next()) 
        nels++;         

      SEXP ans, names;
      PROTECT(ans = NEW_NUMERIC(nels));
      PROTECT(names = NEW_CHARACTER(nels));
      
      int i = 0;
      SET_STRING_ELT(names, 0, Rf_mkChar(word ? word : ""));
      REAL(ans)[0] = conf;

      tesseract::ChoiceIterator ci(*ri);
      for(i = 1; i < nels ; i++, ci.Next()) {
	const char* choice = ci.GetUTF8Text();
	conf = ci.Confidence();
	if(choice)
           SET_STRING_ELT(names, i, Rf_mkChar(choice ? choice : ""));
	REAL(ans)[i] = conf;
	//	delete [] choice;
      }

      SET_NAMES(ans, names);
      UNPROTECT(2);

      return(ans);
}





extern "C"
SEXP
R_TesseractBaseAPI_getBoundingBoxes(SEXP r_api, SEXP r_level)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];  
  return(getRIBoundingBoxes(level, api, R_NilValue));
}


SEXP
getRIBoundingBoxes(tesseract::PageIteratorLevel level, tesseract::TessBaseAPI *api, SEXP r_names)
{
    tesseract::ResultIterator* ri = api->GetIterator();

    if(!ri) {
       Rprintf("Calling Recognize again\n");
       api->Recognize(0);
       ri = api->GetIterator();
       if(!ri) {
          PROBLEM "cannot get ResultIterator"
          ERROR;
       }
    }


    int n = 1, i;
    while(ri->Next(level))   
        n++;

    ri = api->GetIterator();
    SEXP ans, names, tmp;
    PROTECT(names = NEW_CHARACTER(n));
    PROTECT(ans = NEW_LIST(n));
    i = 0;
    int x1, y1, x2, y2;
    do {
      const char* word = ri->GetUTF8Text(level);
      float conf = ri->Confidence(level);

      ri->BoundingBox(level, &x1, &y1, &x2, &y2);
      SET_STRING_ELT(names, i, Rf_mkChar(word ? word : ""));
      SET_VECTOR_ELT(ans, i, tmp = NEW_NUMERIC(5));
      REAL(tmp)[0] = conf;
      REAL(tmp)[1] = x1;
      REAL(tmp)[2] = y1;
      REAL(tmp)[3] = x2;
      REAL(tmp)[4] = y2;

      SET_NAMES(tmp, r_names);

      delete[] word;
      i++;

    } while (ri->Next(level));

    SET_NAMES(ans, names);
    UNPROTECT(2);

   return(ans);
}



/*
#if 0
  i = 0;
  if(ri != 0) {
    int j;
    do {
      const char* symbol = ri->GetUTF8Text(tesseract::RIL_SYMBOL);
      if(symbol) {
	i++;
	tesseract::ChoiceIterator ci(*ri);
	j = 0;
#if 1
	do {
	  j++;
	} while(ci.Next());
#endif
	printf("%s %d\n", symbol, j);
	delete[] symbol;
      }
    } while(ri->Next(level));
  }
  return(ScalarInteger(i));
#endif

 */

