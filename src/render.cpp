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


/*
This is now set via the configure script after testing to see 
if we can compile with this additional parameter.

#define PDF_RENDER_HAS_TEXT_ONLY 1
*/

extern "C"
SEXP
R_Tesseract_RenderAsPDF(SEXP r_api, SEXP r_file, SEXP r_datadir, SEXP r_textOnly)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI);
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    // should make adding r_textOnly optional depending on a configure check.
    tesseract::TessPDFRenderer renderer(CHAR(STRING_ELT(r_file, 0)), CHAR(STRING_ELT(r_datadir, 0))
#ifdef PDF_RENDER_HAS_TEXT_ONLY
					, LOGICAL(r_textOnly)[0]
#endif
                                       );

    bool failed = !renderer.AddImage(api);

    if(failed) {
        PROBLEM "failed to render the boxes"
            ERROR;
    }

    return(R_NilValue);
}


// This is in this file (rather than ext.cpp) to avoid the issue of including
// <tesseract/renderer.h> and avoiding the R #defines for Rf_length and Rf_error.

#if 0
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
#endif

extern "C"
SEXP
R_TessBaseAPI_ProcessPages(SEXP r_api, SEXP r_filename, SEXP r_retry_config, SEXP r_timeout, SEXP r_renderer)
{
    tesseract::TessBaseAPI * api = GET_REF(r_api, tesseract::TessBaseAPI );
    if(!api) {
        PROBLEM "NULL value for api reference"
            ERROR;
    }

    tesseract::TessResultRenderer *renderer = GET_REF(r_renderer, tesseract::TessResultRenderer);
    bool status = api->ProcessPages(CHAR(STRING_ELT(r_filename, 0)), NULL, 0, renderer);

    return(ScalarLogical(status));
}


void
R_finalizePDFRender(SEXP extPtr)
{
   tesseract::TessResultRenderer *renderer = (tesseract::TessResultRenderer *) R_ExternalPtrAddr(extPtr);
   if(renderer)
       delete renderer;
}

extern "C"
SEXP
R_TessPDFRender(SEXP r_file, SEXP r_datadir, SEXP r_textOnly)
{
    tesseract::TessPDFRenderer *renderer;
    renderer = new tesseract::TessPDFRenderer(CHAR(STRING_ELT(r_file, 0)), CHAR(STRING_ELT(r_datadir, 0))
#ifdef PDF_RENDER_HAS_TEXT_ONLY
					, LOGICAL(r_textOnly)[0]
#endif
                                       );

    return(createRef(renderer, "TessPDFRenderer", R_finalizePDFRender));   
}


extern "C"
SEXP
R_TessTsvRender(SEXP r_file, SEXP r_font_info)
{
    tesseract::TessTsvRenderer *renderer;
    renderer = new tesseract::TessTsvRenderer(CHAR(STRING_ELT(r_file, 0)), LOGICAL(r_font_info)[0]);

    return(createRef(renderer, "TessTsvRenderer", R_finalizePDFRender));   
}

extern "C"
SEXP
R_TessHOcrRender(SEXP r_file, SEXP r_font_info)
{
    tesseract::TessHOcrRenderer *renderer;
    renderer = new tesseract::TessHOcrRenderer(CHAR(STRING_ELT(r_file, 0)), LOGICAL(r_font_info)[0]);

    return(createRef(renderer, "TessHOcrRenderer", R_finalizePDFRender));   
}

extern "C"
SEXP
R_TessOsdRender(SEXP r_file)
{
    tesseract::TessOsdRenderer *renderer;
    renderer = new tesseract::TessOsdRenderer(CHAR(STRING_ELT(r_file, 0)));

    return(createRef(renderer, "TessOsdRenderer", R_finalizePDFRender));   
}


extern "C"
SEXP
R_TessBoxTextRender(SEXP r_file)
{
    tesseract::TessBoxTextRenderer *renderer;
    renderer = new tesseract::TessBoxTextRenderer(CHAR(STRING_ELT(r_file, 0)));

    return(createRef(renderer, "TessBoxTextRenderer", R_finalizePDFRender));   
}

extern "C"
SEXP
R_TessUnlvRender(SEXP r_file)
{
    tesseract::TessUnlvRenderer *renderer;
    renderer = new tesseract::TessUnlvRenderer(CHAR(STRING_ELT(r_file, 0)));

    return(createRef(renderer, "TessUnlvRenderer", R_finalizePDFRender));   
}

