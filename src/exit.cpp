#include <stdlib.h>
#include <Rdefines.h>
#include "Rtesseract.h"


static int interceptExit = 0;
void ourExitInterceptor()
{
    if(interceptExit) {
        PROBLEM "intercepted a tesseract call to exit()"
            ERROR;
    }
}

extern "C"
void
R_atexit()
{
    atexit(ourExitInterceptor);    
}

extern "C"
void
R_setAtExitFlag(int *val)
{
    interceptExit = val[0];
}

extern "C"
SEXP
R_getAtExitFlag()
{
    return(ScalarInteger(interceptExit));
}




