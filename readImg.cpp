#include <string>
using std::string;

// We don't need to initialize tesseract. Just use leptonica!
#if 0
#ifndef ADD_TESSERACT_DIR 
#include <baseapi.h> 
#else
#include <tesseract/baseapi.h> 
#endif
#endif

#include <allheaders.h>

int
main(int argc, char *argv[])
{
//  tesseract::TessBaseAPI *api = new tesseract::TessBaseAPI();
  Pix *image = pixRead(argv[1]);
  return( image ? 0 : 1);
}
