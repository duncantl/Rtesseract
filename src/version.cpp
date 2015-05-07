#include <tesseract/baseapi.h>
#include <Rdefines.h>

extern "C"
SEXP
R_tesseract_Version()
{
 return( ScalarString(mkChar( tesseract::TessBaseAPI::Version() )) );
}