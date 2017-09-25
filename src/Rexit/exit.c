#include <stdlib.h>
#include <Rdefines.h>

//extern "C"
void
exit(int status)
{
  fprintf(stderr, "In local exit (Rexit)\n");
  PROBLEM "exiting from tesseract! Caught locally"
      ERROR;
}

//extern "C"
void tprintf_internal(const char *format, ...)
{
  fprintf(stderr, "In local tprintf (Rexit)\n");    
    PROBLEM "[local] tprintf_internal"
      WARN;
}

