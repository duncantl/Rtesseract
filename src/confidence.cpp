#include <tesseract/baseapi.h>
#include <leptonica/allheaders.h>

#include <Rdefines.h>

extern "C"
SEXP
R_ocr(SEXP filename, SEXP r_vars, SEXP r_level)
{
  SEXP ans = R_NilValue; 
  Pix *image = pixRead(CHAR(STRING_ELT(filename, 0)));
  int i;

  tesseract::TessBaseAPI *api = new tesseract::TessBaseAPI();
  api->Init(NULL, "eng");
  api->SetImage(image);

 Rf_PrintValue(r_vars);

 Rf_PrintValue(r_level);

  SEXP r_optNames = GET_NAMES(r_vars);
  for(i = 0; i < Rf_length(r_vars); i++) {
      api->SetVariable(CHAR(STRING_ELT(r_optNames, i)), CHAR(STRING_ELT(r_vars, i)));
  }

  api->Recognize(0);
  tesseract::ResultIterator* ri = api->GetIterator();
  tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];  //RIL_WORD;
  if (ri != 0) {

    int n = 1, i;
    while(ri->Next(level))   n++;
    //    printf("num words %d\n", n);


    //    api->Recognize(0);
    ri = api->GetIterator();
    SEXP names;
    PROTECT(names = NEW_CHARACTER(n));
    PROTECT(ans = NEW_NUMERIC(n));
    i = 0;
    do {
      const char* word = ri->GetUTF8Text(level);
      float conf = ri->Confidence(level);
      //      int x1, y1, x2, y2;
      //      ri->BoundingBox(level, &x1, &y1, &x2, &y2);
      //      printf("word: '%s';  \tconf: %.2f; BoundingBox: %d,%d,%d,%d;\n",
      //	   word, conf, x1, y1, x2, y2);
      SET_STRING_ELT(names, i, Rf_mkChar(word));
      REAL(ans)[i] = conf;
      delete[] word;
      i++;
    } while (ri->Next(level));

    SET_NAMES(ans, names);
    UNPROTECT(2);
  }

 return(ans);
}
