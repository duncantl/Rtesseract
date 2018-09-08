#include <string>
using std::string;

#ifndef ADD_TESSERACT_DIR 
#include <baseapi.h> 
#else
#include <tesseract/baseapi.h> 
#endif

#include <allheaders.h>

int
main(int argc, char *argv[])
{
  tesseract::TessBaseAPI *api = new tesseract::TessBaseAPI();
  Pix *image = pixRead(argv[1]);
  return( image ? 0 : 1);
}
