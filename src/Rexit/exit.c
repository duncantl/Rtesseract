#include <stdlib.h>
#include <Rdefines.h>

//extern "C"
void
exit(int status)
{
//  fprintf(stderr, "In local exit (Rexit)\n");
  PROBLEM "[tesseract 'exit']"
      ERROR;
}

#include <stdio.h>
#include <stdarg.h>

#define R_USE_C99_IN_CXX 1
#include <R_ext/Print.h>
//extern "C"
void tprintf_internal(const char *format, ...)
{
//  fprintf(stderr, "In local tprintf (Rexit)\n");    
//    char buf[100];
//    sprintf(buf, "[tesseract] %s", format);
    va_list args;
    REprintf("%s", "<tesseract> ");
    va_start(args, format);
    REvprintf(format, args);
    va_end(args);
}

