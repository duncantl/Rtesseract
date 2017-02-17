#include <tesseract/osdetect.h>
#include "Rtesseract.h"

extern "C"
SEXP
R_TessBaseAPI_new()
{
  tesseract::TessBaseAPI *api = new tesseract::TessBaseAPI();
  return(createRef(api, "TesseractBaseAPI", R_freeAPI));
}

void
R_freeAPI(SEXP obj)
{
  tesseract::TessBaseAPI * api = (tesseract::TessBaseAPI *)  R_ExternalPtrAddr(obj)  ;
  if(api) {
#ifdef FINALIZER_DEBUG
    Rprintf("R_freeAPI\n");
#endif
    delete api;
  }
}

extern "C"
SEXP
R_TessBaseAPI_Init(SEXP r_api, SEXP r_lang, SEXP r_datapath)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  const char *lang = CHAR(STRING_ELT(r_lang, 0));
  const char *datapath = NULL;
  if(STRING_ELT(r_datapath, 0) != NA_STRING)
      datapath = CHAR(STRING_ELT(r_datapath, 0));
  int ok = api->Init(datapath, lang); 

  return( ScalarLogical( ok == 0 ));
}


#ifdef error
#undef error
#endif

#include <tesseract/genericvector.h>

#define error Rf_error


extern "C"
SEXP
R_TessBaseAPI_Init2(SEXP r_api, SEXP r_lang, SEXP r_datapath, 
                    SEXP r_engMode, SEXP r_configs, SEXP r_vars, SEXP r_debugOnly)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  const char *lang = CHAR(STRING_ELT(r_lang, 0));
  const char *datapath = NULL;
  if(STRING_ELT(r_datapath, 0) != NA_STRING)
      datapath = CHAR(STRING_ELT(r_datapath, 0));
  tesseract::OcrEngineMode engMode = (tesseract::OcrEngineMode) INTEGER(r_engMode)[0];
  int numConfigs = Rf_length(r_configs), i;
  char **configs = NULL;
  if(numConfigs > 0)  {
      configs = (char **) R_alloc(sizeof(char*), numConfigs);
      for(i = 0; i < numConfigs ;  i++)
          configs[i] = (char *) CHAR(STRING_ELT(r_configs, i));
  }

  GenericVector<STRING> vars_vec, vars_values;

  int ok = api->Init(datapath, lang, engMode, configs, numConfigs, &vars_vec, &vars_values, INTEGER(r_debugOnly)[0]); 

  return( ScalarLogical( ok == 0 ));
}


extern "C"
SEXP
R_TessBaseAPI_SetVariables(SEXP r_api, SEXP r_vars)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  SEXP r_optNames = GET_NAMES(r_vars), ans;
  int i;
  PROTECT(ans = NEW_LOGICAL(Rf_length(r_vars)));
  for(i = 0; i < Rf_length(r_vars); i++)  {
//      Rprintf("set var: %s = %s\n", CHAR(STRING_ELT(r_optNames, i)), CHAR(STRING_ELT(r_vars, i)));
      LOGICAL(ans)[i] = api->SetVariable(CHAR(STRING_ELT(r_optNames, i)), CHAR(STRING_ELT(r_vars, i)));
  }
  SET_NAMES(ans, r_optNames);
  UNPROTECT(1);

  return( ans );
}


extern "C"
SEXP
R_TessBaseAPI_End(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  api->End();

  return(R_NilValue);
}


extern "C"
SEXP
R_TessBaseAPI_SetImage(SEXP r_api, SEXP r_img)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  Pix *img = GET_REF(r_img, Pix);
  if(!img) {
      PROBLEM "NULL value passed for image (Pix)"
      ERROR;
  }
  api->SetImage(img);

  return(R_NilValue);
}


extern "C"
SEXP
R_TessBaseAPI_SetImage_raw(SEXP r_api, SEXP r_img, SEXP r_dims, SEXP r_bytes_per_pixel, SEXP r_bytes_per_line)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }
 
  unsigned char *img = (unsigned char *) RAW(r_img);
  api->SetImage(img, INTEGER(r_dims)[0], INTEGER(r_dims)[1], INTEGER(r_bytes_per_pixel)[0], INTEGER(r_bytes_per_line)[0]);

  return(R_NilValue);
}


extern "C"
SEXP
R_TessBaseAPI_GetInputImage(SEXP r_api, SEXP r_asArray)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    Pix *pix = api->GetInputImage();
    if(LOGICAL(r_asArray)[0])
      return(getPixAsArray(pix));

  return(createRef(pix, "Pix", R_pixDestroy)); //XXX Put a finalizer on this and bump the reference count
}

extern "C"
SEXP
R_TessBaseAPI_GetThresholdedImageScaleFactor(SEXP r_api)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }
    int val = api->GetThresholdedImageScaleFactor();
    return(ScalarInteger(val));
}

extern "C"
SEXP
R_TessBaseAPI_GetThresholdedImage(SEXP r_api)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    Pix *pix = api->GetThresholdedImage();
    return(createRef(pix, "Pix", R_pixDestroy)); //XXX Put a finalizer on this and bump the reference count
}


extern "C"
SEXP
R_pixRead(SEXP r_filename)
{
  Pix *image = pixRead(CHAR(STRING_ELT(r_filename, 0)));
  return(createRef(image, "Pix", R_pixDestroy)); //XXX Put a finalizer on this and bump the reference count
}

void
R_pixDestroy(SEXP obj)
{
  Pix *p = (Pix *) R_ExternalPtrAddr(obj);
  if(p) {
#ifdef FINALIZER_DEBUG
     Rprintf("R_pixDestroy\n");
#endif
     pixDestroy(&p);
     R_SetExternalPtrAddr(obj, NULL);
  }
}

SEXP
createRef(void *ptr, const char * const classname, R_CFinalizer_t fin)
{
  SEXP robj, klass, ref;

 
  PROTECT(klass = MAKE_CLASS(classname));
  PROTECT(robj = NEW(klass));
  SET_SLOT(robj, Rf_install("ref"), ref = R_MakeExternalPtr(ptr, Rf_install(classname), R_NilValue));

  // Set finalizer to garbage collect when we let go/release this object.
  if(fin)
     R_RegisterCFinalizer(ref, fin);
  UNPROTECT(2);  
  return(robj);
}


extern "C"
SEXP
R_TessBaseAPI_Recognize(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }
  return(ScalarLogical(api->Recognize(NULL) == 0));
}


extern "C"
SEXP
R_TessBaseAPI_GetIterator(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }
  tesseract::ResultIterator* ri = api->GetIterator();
  if(!ri) {
      return(R_NilValue);
      PROBLEM "ResultIterator is NULL. Did you call Recognize" 
      ERROR;
  }
  return(createRef(ri, "ResultIterator", R_freeResultIterator));
}


typedef SEXP (*NativeIteratorFun)(tesseract::ResultIterator *, tesseract::PageIteratorLevel);


// XXX Does getAllAlternatives do what we have here less generally
extern "C"
SEXP
R_ResultIterator_lapply(SEXP r_it, SEXP r_level, SEXP r_fun)
{
   tesseract::ResultIterator *ri = GET_REF(r_it, tesseract::ResultIterator);
   ri->Begin();
   int n = 1, i;

   tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];

   while(ri->Next(level)) n++;

   SEXP names, ans, el;
   PROTECT(names = NEW_CHARACTER(n));
   PROTECT(ans = NEW_LIST(n));   
   i = 0;
   ri->Begin();

   NativeIteratorFun fun = NULL;

   if(TYPEOF(r_fun) == EXTPTRSXP)
     fun = (NativeIteratorFun) R_ExternalPtrAddr(r_fun);

   do {
      const char* word = ri->GetUTF8Text(level);
      SET_STRING_ELT(names, i, Rf_mkChar(word ? word : ""));
      if(fun)
	el = fun(ri, level);
      else
        el = Rf_eval(r_fun, R_GlobalEnv);
      SET_VECTOR_ELT(ans, i, el);
      delete[] word;
      i++;
   } while(ri->Next(level));

   SET_NAMES(ans, names);
   UNPROTECT(2);
   return(ans);
}

/* eventhough we don't call this directly from R, we need to be able to get the symbol.
 */
extern "C"  
SEXP
r_getConfidence(tesseract::ResultIterator *ri, tesseract::PageIteratorLevel level)
{
  return(ScalarReal( ri->Confidence(level) ));
}

void
R_freeResultIterator(SEXP obj)
{
  tesseract::ResultIterator* api = (tesseract::ResultIterator *)  R_ExternalPtrAddr(obj)  ;
  if(api)
    delete api;
}




extern "C"
SEXP
R_ResultIterator_BoundingBox(SEXP r_it, SEXP r_level)
{

   tesseract::ResultIterator *ri = GET_REF(r_it, tesseract::ResultIterator);
   tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];

    int x1, y1, x2, y2;
    ri->BoundingBox(level, &x1, &y1, &x2, &y2); 
    SEXP tmp = NEW_NUMERIC(4); // Note: Don't need to protect.
      REAL(tmp)[0] = x1;
      REAL(tmp)[1] = y1;
      REAL(tmp)[2] = x2;
      REAL(tmp)[3] = y2;
    return(tmp);
}


extern "C"
SEXP
R_ResultIterator_Confidence(SEXP r_it, SEXP r_level)
{

   tesseract::ResultIterator *ri = GET_REF(r_it, tesseract::ResultIterator);
   tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];

   return(ScalarReal(ri->Confidence(level)));
}

extern "C"
SEXP
R_ResultIterator_GetUTF8Text(SEXP r_it, SEXP r_level)
{

   tesseract::ResultIterator *ri = GET_REF(r_it, tesseract::ResultIterator);
   tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];

   const char * val = ri->GetUTF8Text(level);
   SEXP ans = ScalarString(mkChar(val ? val : ""));
   delete[] val;

   return(ans);
}



extern "C"
SEXP
R_tesseract_GetInitLanguagesAsString(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  const char * const str = api->GetInitLanguagesAsString();
  return(ScalarString(mkChar(str ? str : "")));
}



extern "C"
SEXP
R_tesseract_ReadConfigFile(SEXP r_api, SEXP r_filename)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  for(int i = 0; i < Rf_length(r_filename); i++)
    api->ReadConfigFile(CHAR(STRING_ELT(r_filename, i)));

  return(R_NilValue);
}


extern "C"
SEXP
R_tesseract_SetSourceResolution(SEXP r_api, SEXP r_ppi)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  api->SetSourceResolution(INTEGER(r_ppi)[0]);

  return(R_NilValue);
}


extern "C"
SEXP
R_tesseract_SetRectangle(SEXP r_api, SEXP r_dims)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  int *d = INTEGER(r_dims);
  api->SetRectangle(d[0], d[1], d[2], d[3]);

  return(R_NilValue);
}


extern "C"
SEXP
R_tesseract_Clear(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  api->Clear();

  return(ScalarLogical(true));
}

extern "C"
SEXP
R_tesseract_ClearAdaptiveClassifier(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  api->ClearAdaptiveClassifier();

  return(ScalarLogical(true));
}


extern "C"
SEXP
R_tesseract_ClearPersistentCache()
{
    tesseract::TessBaseAPI::ClearPersistentCache();
    return(ScalarLogical(true));
}



#if 1
#include <strngs.h>
#include <R_ext/Arith.h>

SEXP
getVariable(tesseract::TessBaseAPI * api, const char *varname, int type)
{
    int i;
    double d;
    bool b;
    
    STRING str;

#if 0
 Rprintf("var: %s\n", varname);
 bool ok = api->GetBoolVariable(varname, &b);
 Rprintf("%d %d\n", (int)ok, (int) b);

// api->GetVariableAsString(varname, &str);
//    return(ScalarString( mkChar(str.c_str() ) ));
#endif

    if(api->GetIntVariable(varname, &i))
        return(ScalarInteger(i));
    if(api->GetDoubleVariable(varname, &d))
        return(ScalarReal(d));
    if(api->GetBoolVariable(varname, &b))
        return(ScalarLogical(b));
    if(api->GetVariableAsString(varname, &str))
        return(ScalarString( mkChar(str.string/* was c_str*/() ) ) );
    
    return(R_NilValue);
}

extern "C"
SEXP
R_tesseract_GetVariable(SEXP r_api, SEXP r_var, SEXP r_type)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );

  int n = Rf_length(r_var);
  SEXP ans;
  PROTECT(ans = NEW_LIST(n));
  for(int i = 0; i < n; i++) 
      SET_VECTOR_ELT(ans, i, getVariable(api, CHAR(STRING_ELT(r_var, i)), INTEGER(r_type)[i]));

  SET_NAMES(ans, r_var);
  UNPROTECT(1);

  return(ans);
}

#endif



extern "C"
SEXP
R_tesseract_IsValidWord(SEXP r_api, SEXP r_words)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    SEXP ans;
    int n = Rf_length(r_words);
    PROTECT(ans = NEW_LOGICAL(n));
    for(int i = 0; i < n; i ++)
        LOGICAL(ans)[i] = api->IsValidWord(CHAR(STRING_ELT(r_words, i)));

    SET_NAMES(ans, r_words);
    UNPROTECT(1);
    return(ans);
}

extern "C"
SEXP
R_tesseract_GetInputName(SEXP r_api)
{
    const char * w = NULL;
#ifdef HAS_GETINPUT_NAME
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    w = api->GetInputName() ;
#else
    PROBLEM "accessing the name of the original document not supported in this version of tesseract"
        WARN;
#endif
    return(ScalarString( w ? mkChar( w ) : NA_STRING  ) );
}



extern "C"
SEXP
R_tesseract_SetInputName(SEXP r_api, SEXP r_name)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    api->SetInputName(CHAR( STRING_ELT(r_name, 0) )) ;
    return(R_NilValue);
}


extern "C"
SEXP
R_tesseract_GetDatapath(SEXP r_api)
{
#ifdef HAS_GETDATAPATH
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    return(ScalarString( mkChar( api->GetDatapath() ) ) );
#else
    PROBLEM "accessing the name of the original document not supported in this version of tesseract"
        WARN;
    return(R_NilValue);
#endif

}

extern "C"
SEXP
R_tesseract_GetSourceYResolution(SEXP r_api)
{
#ifdef HAS_GETSOURCEYRESOLUTION
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    return(ScalarInteger( api->GetSourceYResolution() ) );
#else
    PROBLEM "GetSourceYResolution not support in this version of the tesseract API"
        WARN;
    return(R_NilValue);
#endif
}


extern "C"
SEXP
R_tesseract_PrintVariables(SEXP r_api, SEXP r_filename)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    FILE *f = fopen(CHAR(STRING_ELT(r_filename, 0)), "w");
    if(!f) {
        PROBLEM "cannot write to temporary file %s", CHAR(STRING_ELT(r_filename, 0))
            ERROR;
    }
    api->PrintVariables(f);
    fclose(f);
    return(R_NilValue);
}



//XXX Compare to 
// SEXP getAlternatives(tesseract::ResultIterator* ri, const char *word, float conf)
// currently in confidence.cpp.
// Here nels = 1 initially, in the other it is nels = 2
extern "C"
SEXP
getAlts(tesseract::ResultIterator *ri, tesseract::PageIteratorLevel level)
{
      tesseract::ChoiceIterator ci_r(*ri);
      int nels = 1;
      while(ci_r.Next()) 
        nels++;         

      SEXP ans, names;
      PROTECT(ans = NEW_NUMERIC(nels));
      PROTECT(names = NEW_CHARACTER(nels));

      tesseract::ChoiceIterator ci(*ri);
      double conf;
      for(int i = 0; i < nels ; i++, ci.Next()) {
	const char* choice = ci.GetUTF8Text();
	conf = ci.Confidence();
	if(choice) {
           SET_STRING_ELT(names, i, Rf_mkChar(choice ? choice : ""));
//          delete [] choice;
        }
	REAL(ans)[i] = conf;
      }

      SET_NAMES(ans, names);
      UNPROTECT(2);

      return(ans);
}

extern "C"
SEXP
R_Current_getAlternatives(SEXP r_api, SEXP r_level)
{
    tesseract::ResultIterator *ri = GET_REF(r_api, tesseract::ResultIterator );

    tesseract::PageIteratorLevel level = (tesseract::PageIteratorLevel) INTEGER(r_level)[0];

    return(getAlts(ri, level));
}





extern "C"
SEXP
R_TessBaseAPI_GetPageSegMode(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  tesseract::PageSegMode ans = api->GetPageSegMode();

  return( Renum_convert_PageSegMode(ans) );
}


extern "C"
SEXP
R_TessBaseAPI_SetPageSegMode(SEXP r_api, SEXP r_val)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }
  
  tesseract::PageSegMode val = (tesseract::PageSegMode)  INTEGER(r_val)[0];
  api->SetPageSegMode(val);

  return( ScalarLogical( TRUE));
}



SEXP
makeImageDims(Pix *pix)
{
    if(!pix)
        return(R_NilValue); // or a numeric vector of length 5 of NAs

    SEXP ans = NEW_NUMERIC(3);
    REAL(ans)[0] = pix->h;
    REAL(ans)[1] = pix->w;
    REAL(ans)[2] = pix->d;
    return(ans);
}


extern "C"
SEXP
R_Pix_GetDimensions(SEXP r_pix)
{
    Pix *pix = GET_REF(r_pix, Pix);
    return(makeImageDims(pix));
}

extern "C"
SEXP
R_TessBaseAPI_GetImageDimensions(SEXP r_api)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    Pix *pix = api->GetInputImage();
    return(makeImageDims(pix));
}


SEXP
makeImageInfo(Pix *pix)
{
    if(!pix)
        return(R_NilValue); // or a numeric vector of length 5 of NAs

    SEXP ans = NEW_NUMERIC(5);
    REAL(ans)[0] = pix->spp;
    REAL(ans)[1] = pix->xres;
    REAL(ans)[2] = pix->yres;
    REAL(ans)[3] = pix->informat;
    REAL(ans)[4] = pix->colormap ? pix->colormap->depth : R_NaReal;
    return(ans);
}

extern "C"
SEXP
R_Pix_GetInfo(SEXP r_pix)
{
    Pix *pix = GET_REF(r_pix, Pix);
    return(makeImageInfo(pix));
}

extern "C"
SEXP
R_TessBaseAPI_GetImageInfo(SEXP r_api)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    Pix *pix = api->GetInputImage();
    return(makeImageInfo(pix));
}




extern "C"
SEXP
R_TessBaseAPI_AdaptToWordStr(SEXP r_api, SEXP r_segMode, SEXP r_word)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    tesseract::PageSegMode segMode = (tesseract::PageSegMode) INTEGER(r_segMode)[0];
    
    bool ans = api->AdaptToWordStr(segMode, CHAR(STRING_ELT(r_word, 0)));
    return(ScalarLogical(ans));
}


#if 0
// This is a protected method so not accessible.
extern "C"
SEXP
R_TessBaseAPI_AdaptToChar(SEXP r_api, SEXP r_char, SEXP r_dim_info)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    double *dims = REAL(r_dim_info);
    api->AdaptToCharacter(CHAR(STRING_ELT(r_char, 0)), 1, dims[0], dims[1], dims[2], dims[3]);
    return(R_NilValue);
}
#endif

extern SEXP Renum_convert_OcrEngineMode(tesseract::OcrEngineMode val);

extern "C"
SEXP
R_TessBaseAPI_oem(SEXP r_api)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }
    return(Renum_convert_OcrEngineMode( api->oem()));
    
}



#if 0
// No user data passed to DictFunc. So harder to use an R function.
// Can compile one eventually with Rllvm.

int 
foo(void *args, UNICHAR_ID unichar_id , bool wordEnd)
{
    printf("In foo for dictionary\n");
    return(1);
}


extern "C"
SEXP
R_TessBaseAPI_SetDictFunc(SEXP r_api, SEXP r_fun)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }
    const tesseract::DictFunc f = foo;
    api->SetDictFunc(f);

}
#endif



extern "C"
SEXP
R_TessBaseAPI_hasRecognized(SEXP r_api)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }
    return(ScalarLogical (  api->GetIterator() != NULL ) );
}



extern "C"
SEXP
R_TessBaseAPI_SetOutputName(SEXP r_api, SEXP r_output)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  api->SetOutputName(CHAR(STRING_ELT(r_output, 0)));

  return(R_NilValue);
}


extern "C"
SEXP
R_TessBaseAPI_GetTextDirection(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }
  int offset;
  float slope;
  bool ans = api->GetTextDirection(&offset, &slope);
  if(!ans) {
      return(R_NilValue);
  }
  SEXP r_ans = NEW_NUMERIC(2);
  REAL(r_ans)[0] = offset;
  REAL(r_ans)[1] = slope;
  return(r_ans);
}


#if 1

extern "C"
SEXP
R_TessBaseAPI_DetectOS(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }
  OSResults res;
  bool ans = api->DetectOS(&res);
  if(!ans) {
      return(R_NilValue);
  }
  res.print_scores();
//  int w = res.get_best_script();
  SEXP r_ans, el;
  PROTECT(r_ans = NEW_LIST(2));
//  SET_VECTOR_ELT(r_ans, 0, ScalarInteger(w));
  SET_VECTOR_ELT(r_ans, 0, el = NEW_NUMERIC(4));
  int i, j;
  for(i = 0; i < 4; i++) 
      REAL(el)[i] = res.orientations[i];

  SET_VECTOR_ELT(r_ans, 1, el = NEW_NUMERIC(4*kMaxNumberOfScripts));
  for(i = 0; i < 4; i++) {
      for(j = 0; j < kMaxNumberOfScripts; j++)
          REAL(el)[i + j*3] = res.scripts_na[i][j];
  }
  UNPROTECT(1);
  return(r_ans);
}
#endif






#ifdef error
#undef error
#endif

#include <tesseract/genericvector.h>

#define error Rf_error
#undef length

extern "C"
SEXP
R_TessBaseAPI_GetAvailableLanguagesAsVector(SEXP r_api)
{
  tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
  if(!api) {
      PROBLEM "NULL value for api reference"
      ERROR;
  }

  GenericVector<STRING> langs;
  api->GetAvailableLanguagesAsVector(&langs);

  int i = 0, len = langs.length();
  SEXP r_ans;
  PROTECT(r_ans = NEW_CHARACTER(len));
  for(i = 0; i < len; i++) {
      SET_STRING_ELT(r_ans, i, Rf_mkChar(langs.get(i).string()));
  }
  UNPROTECT(1);

  return(r_ans) ;
}
