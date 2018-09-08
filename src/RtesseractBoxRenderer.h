#ifndef ADD_TESSERACT_DIR 
#include <renderer.h>
#else
#include <tesseract/renderer.h>
#endif

class RTessBoxTextRenderer : public tesseract::TessResultRenderer /* BoxTextRenderer */ {

public:
// tesseract::TessResultRenderer((const char *) "/tmp/ffff", (const char *) "crap")
RTessBoxTextRenderer() : tesseract::TessResultRenderer("abc", "abc") { nprotect = 0; ans = NULL; count = 0;};
    bool BeginDocument(const char* title); 
    bool BeginDocumentHandler(){return(true);}; 
    bool EndDocument(){return true;};
    bool EndDocumentHandler(){return(true);}; 

    void AppendString(const char* s);

    bool AddImage(tesseract::TessBaseAPI* api);
    bool AddImageHandler(tesseract::TessBaseAPI* api);

    ~RTessBoxTextRenderer() {
        UNPROTECT(nprotect);
    }

    SEXP getRVector() {
	if(!ans)
           return(R_NilValue);
        PROTECT(SET_LENGTH(ans, count));
        return(ans);
    }
protected:
    SEXP ans;
    int nprotect;
    int count;
};

