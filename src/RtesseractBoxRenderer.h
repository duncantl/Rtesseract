#include <tesseract/renderer.h>

class RTessBoxTextRenderer : public tesseract::TessBoxTextRenderer {

public:
    RTessBoxTextRenderer() : tesseract::TessBoxTextRenderer((const char *) "/tmp/ffff")  { nprotect = 0; ans = NULL; count = 0;};
    bool BeginDocument(const char* title) {return true;}
    bool EndDocument(){return true;};

    void AppendString(const char* s);

    ~RTessBoxTextRenderer() {
        UNPROTECT(nprotect);
    }

    SEXP getRVector() {
        PROTECT(SET_LENGTH(ans, count));
        return(ans);
    }
protected:
    SEXP ans;
    int nprotect;
    int count;
};

