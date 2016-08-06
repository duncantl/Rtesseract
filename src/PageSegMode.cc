#include "Rtesseract.h"
#include "RConverters.h"

SEXP
Renum_convert_PageSegMode(tesseract::PageSegMode val)
{
const char *elName;
switch(val) {
   case tesseract::PSM_OSD_ONLY:
	elName = "tesseract::PSM_OSD_ONLY";
	break;
   case tesseract::PSM_AUTO_OSD:
	elName = "tesseract::PSM_AUTO_OSD";
	break;
   case tesseract::PSM_AUTO_ONLY:
	elName = "tesseract::PSM_AUTO_ONLY";
	break;
   case tesseract::PSM_AUTO:
	elName = "tesseract::PSM_AUTO";
	break;
   case tesseract::PSM_SINGLE_COLUMN:
	elName = "tesseract::PSM_SINGLE_COLUMN";
	break;
   case tesseract::PSM_SINGLE_BLOCK_VERT_TEXT:
	elName = "tesseract::PSM_SINGLE_BLOCK_VERT_TEXT";
	break;
   case tesseract::PSM_SINGLE_BLOCK:
	elName = "tesseract::PSM_SINGLE_BLOCK";
	break;
   case tesseract::PSM_SINGLE_LINE:
	elName = "tesseract::PSM_SINGLE_LINE";
	break;
   case tesseract::PSM_SINGLE_WORD:
	elName = "tesseract::PSM_SINGLE_WORD";
	break;
   case tesseract::PSM_CIRCLE_WORD:
	elName = "tesseract::PSM_CIRCLE_WORD";
	break;
   case tesseract::PSM_SINGLE_CHAR:
	elName = "tesseract::PSM_SINGLE_CHAR";
	break;
   case tesseract::PSM_SPARSE_TEXT:
	elName = "tesseract::PSM_SPARSE_TEXT";
	break;
   case tesseract::PSM_SPARSE_TEXT_OSD:
	elName = "tesseract::PSM_SPARSE_TEXT_OSD";
	break;
   case tesseract::PSM_RAW_LINE:
	elName = "tesseract::PSM_RAW_LINE";
	break;
   case tesseract::PSM_COUNT:
	elName = "tesseract::PSM_COUNT";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "PageSegMode"));
}
