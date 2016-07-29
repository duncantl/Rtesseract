#include <baseapi.h>
#include <allheaders.h>

int
main(int argc, char *argv[])
{
  tesseract::TessBaseAPI *api = new tesseract::TessBaseAPI();
  Pix *image = pixRead(argv[1]);
  return( image ? 0 : 1);
}
