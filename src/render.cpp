#include "Rtesseract.h"

#include "RtesseractBoxRenderer.h"

extern "C"
SEXP
R_Tesseract_RenderBoxes(SEXP r_api)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    RTessBoxTextRenderer renderer;
//    tesseract::TessBoxTextRenderer renderer("/tmp/ffff");

    bool failed = !renderer.AddImage(api);

    if(failed) {
        PROBLEM "failed to render the boxes"
            ERROR;
    }

    return( renderer.getRVector() );
//    return(R_NilValue);
}



extern "C"
SEXP
R_Tesseract_RenderAsPDF(SEXP r_api, SEXP r_file, SEXP r_datadir)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    tesseract::TessPDFRenderer renderer(CHAR(STRING_ELT(r_file, 0)), CHAR(STRING_ELT(r_datadir, 0)));

    bool failed = !renderer.AddImage(api);

    if(failed) {
        PROBLEM "failed to render the boxes"
            ERROR;
    }

    return(R_NilValue);
}


// This is in this file (rather than ext.cpp) to avoid the issue of including
// <tesseract/renderer.h> and avoiding the R #defines for Rf_length and Rf_error.

extern "C"
SEXP
R_TessBaseAPI_ProcessPages(SEXP r_api, SEXP r_filename, SEXP r_retry_config, SEXP r_timeout, SEXP r_renderer)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    tesseract::TessTextRenderer renderer("/tmp/foo.rout");
    const char *filename = CHAR(STRING_ELT(r_filename, 0));
    bool status = api->ProcessPages(filename, NULL, 0, &renderer);
    return(ScalarLogical(status));
}
