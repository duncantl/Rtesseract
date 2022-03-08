#include "Rtesseract.h"
#include "RConverters.h"


#ifdef POLYBLOCKTYPE_IN_TESSERACT_NAMESPACE
SEXP
Renum_convert_PolyBlockType(tesseract::PolyBlockType val)
{
const char *elName;
switch(val) {
   case tesseract::PT_UNKNOWN:
	elName = "tesseract::PT_UNKNOWN";
	break;
   case tesseract::PT_FLOWING_TEXT:
	elName = "tesseract::PT_FLOWING_TEXT";
	break;
   case tesseract::PT_HEADING_TEXT:
	elName = "tesseract::PT_HEADING_TEXT";
	break;
   case tesseract::PT_PULLOUT_TEXT:
	elName = "tesseract::PT_PULLOUT_TEXT";
	break;
   case tesseract::PT_EQUATION:
	elName = "tesseract::PT_EQUATION";
	break;
   case tesseract::PT_INLINE_EQUATION:
	elName = "tesseract::PT_INLINE_EQUATION";
	break;
   case tesseract::PT_TABLE:
	elName = "tesseract::PT_TABLE";
	break;
   case tesseract::PT_VERTICAL_TEXT:
	elName = "tesseract::PT_VERTICAL_TEXT";
	break;
   case tesseract::PT_CAPTION_TEXT:
	elName = "tesseract::PT_CAPTION_TEXT";
	break;
   case tesseract::PT_FLOWING_IMAGE:
	elName = "tesseract::PT_FLOWING_IMAGE";
	break;
   case tesseract::PT_HEADING_IMAGE:
	elName = "tesseract::PT_HEADING_IMAGE";
	break;
   case tesseract::PT_PULLOUT_IMAGE:
	elName = "tesseract::PT_PULLOUT_IMAGE";
	break;
   case tesseract::PT_HORZ_LINE:
	elName = "tesseract::PT_HORZ_LINE";
	break;
   case tesseract::PT_VERT_LINE:
	elName = "tesseract::PT_VERT_LINE";
	break;
   case tesseract::PT_NOISE:
	elName = "tesseract::PT_NOISE";
	break;
   case tesseract::PT_COUNT:
	elName = "tesseract::PT_COUNT";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "PolyBlockType"));
}

#else

SEXP
Renum_convert_PolyBlockType(PolyBlockType val)
{
const char *elName;
switch(val) {
   case PT_UNKNOWN:
	elName = "PT_UNKNOWN";
	break;
   case PT_FLOWING_TEXT:
	elName = "PT_FLOWING_TEXT";
	break;
   case PT_HEADING_TEXT:
	elName = "PT_HEADING_TEXT";
	break;
   case PT_PULLOUT_TEXT:
	elName = "PT_PULLOUT_TEXT";
	break;
   case PT_EQUATION:
	elName = "PT_EQUATION";
	break;
   case PT_INLINE_EQUATION:
	elName = "PT_INLINE_EQUATION";
	break;
   case PT_TABLE:
	elName = "PT_TABLE";
	break;
   case PT_VERTICAL_TEXT:
	elName = "PT_VERTICAL_TEXT";
	break;
   case PT_CAPTION_TEXT:
	elName = "PT_CAPTION_TEXT";
	break;
   case PT_FLOWING_IMAGE:
	elName = "PT_FLOWING_IMAGE";
	break;
   case PT_HEADING_IMAGE:
	elName = "PT_HEADING_IMAGE";
	break;
   case PT_PULLOUT_IMAGE:
	elName = "PT_PULLOUT_IMAGE";
	break;
   case PT_HORZ_LINE:
	elName = "PT_HORZ_LINE";
	break;
   case PT_VERT_LINE:
	elName = "PT_VERT_LINE";
	break;
   case PT_NOISE:
	elName = "PT_NOISE";
	break;
   case PT_COUNT:
	elName = "PT_COUNT";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "PolyBlockType"));
}

#endif


SEXP
Renum_convert_Orientation(tesseract::Orientation val)
{
const char *elName;
switch(val) {
   case tesseract::ORIENTATION_PAGE_UP:
	elName = "tesseract::ORIENTATION_PAGE_UP";
	break;
   case tesseract::ORIENTATION_PAGE_RIGHT:
	elName = "tesseract::ORIENTATION_PAGE_RIGHT";
	break;
   case tesseract::ORIENTATION_PAGE_DOWN:
	elName = "tesseract::ORIENTATION_PAGE_DOWN";
	break;
   case tesseract::ORIENTATION_PAGE_LEFT:
	elName = "tesseract::ORIENTATION_PAGE_LEFT";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "Orientation"));
}
SEXP
Renum_convert_WritingDirection(tesseract::WritingDirection val)
{
const char *elName;
switch(val) {
   case tesseract::WRITING_DIRECTION_LEFT_TO_RIGHT:
	elName = "tesseract::WRITING_DIRECTION_LEFT_TO_RIGHT";
	break;
   case tesseract::WRITING_DIRECTION_RIGHT_TO_LEFT:
	elName = "tesseract::WRITING_DIRECTION_RIGHT_TO_LEFT";
	break;
   case tesseract::WRITING_DIRECTION_TOP_TO_BOTTOM:
	elName = "tesseract::WRITING_DIRECTION_TOP_TO_BOTTOM";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "WritingDirection"));
}
SEXP
Renum_convert_TextlineOrder(tesseract::TextlineOrder val)
{
const char *elName;
switch(val) {
   case tesseract::TEXTLINE_ORDER_LEFT_TO_RIGHT:
	elName = "tesseract::TEXTLINE_ORDER_LEFT_TO_RIGHT";
	break;
   case tesseract::TEXTLINE_ORDER_RIGHT_TO_LEFT:
	elName = "tesseract::TEXTLINE_ORDER_RIGHT_TO_LEFT";
	break;
   case tesseract::TEXTLINE_ORDER_TOP_TO_BOTTOM:
	elName = "tesseract::TEXTLINE_ORDER_TOP_TO_BOTTOM";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "TextlineOrder"));
}
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
SEXP
Renum_convert_PageIteratorLevel(tesseract::PageIteratorLevel val)
{
const char *elName;
switch(val) {
   case tesseract::RIL_BLOCK:
	elName = "tesseract::RIL_BLOCK";
	break;
   case tesseract::RIL_PARA:
	elName = "tesseract::RIL_PARA";
	break;
   case tesseract::RIL_TEXTLINE:
	elName = "tesseract::RIL_TEXTLINE";
	break;
   case tesseract::RIL_WORD:
	elName = "tesseract::RIL_WORD";
	break;
   case tesseract::RIL_SYMBOL:
	elName = "tesseract::RIL_SYMBOL";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "PageIteratorLevel"));
}
SEXP
Renum_convert_ParagraphJustification(tesseract::ParagraphJustification val)
{
const char *elName;
switch(val) {
   case tesseract::JUSTIFICATION_UNKNOWN:
	elName = "tesseract::JUSTIFICATION_UNKNOWN";
	break;
   case tesseract::JUSTIFICATION_LEFT:
	elName = "tesseract::JUSTIFICATION_LEFT";
	break;
   case tesseract::JUSTIFICATION_CENTER:
	elName = "tesseract::JUSTIFICATION_CENTER";
	break;
   case tesseract::JUSTIFICATION_RIGHT:
	elName = "tesseract::JUSTIFICATION_RIGHT";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "ParagraphJustification"));
}
SEXP
Renum_convert_OcrEngineMode(tesseract::OcrEngineMode val)
{
const char *elName;
switch(val) {
   case tesseract::OEM_TESSERACT_ONLY:
	elName = "tesseract::OEM_TESSERACT_ONLY";
	break;
   case tesseract::OEM_LSTM_ONLY:
	elName = "tesseract::OEM_LSTM_ONLY";
	break;
   case tesseract::OEM_TESSERACT_LSTM_COMBINED:
	elName = "tesseract::OEM_TESSERACT_LSTM_COMBINED";
	break;
   case tesseract::OEM_DEFAULT:
	elName = "tesseract::OEM_DEFAULT";
	break;
   case tesseract::OEM_COUNT:
	elName = "tesseract::OEM_COUNT";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "OcrEngineMode"));
}


#ifdef STRONGSCRIPTDIRECTION_IN_TESSERACT_NAMESPACE
SEXP
Renum_convert_StrongScriptDirection(tesseract::StrongScriptDirection val)
{
const char *elName;
switch(val) {
   case tesseract::DIR_NEUTRAL:
	elName = "tesseract::DIR_NEUTRAL";
	break;
   case tesseract::DIR_LEFT_TO_RIGHT:
	elName = "tesseract::DIR_LEFT_TO_RIGHT";
	break;
   case tesseract::DIR_RIGHT_TO_LEFT:
	elName = "tesseract::DIR_RIGHT_TO_LEFT";
	break;
   case tesseract::DIR_MIX:
	elName = "tesseract::DIR_MIX";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "StrongScriptDirection"));
}

#else


SEXP
Renum_convert_StrongScriptDirection(StrongScriptDirection val)
{
const char *elName;
switch(val) {
   case DIR_NEUTRAL:
	elName = "DIR_NEUTRAL";
	break;
   case DIR_LEFT_TO_RIGHT:
	elName = "DIR_LEFT_TO_RIGHT";
	break;
   case DIR_RIGHT_TO_LEFT:
	elName = "DIR_RIGHT_TO_LEFT";
	break;
   case DIR_MIX:
	elName = "DIR_MIX";
	break;
   default:
	elName = "?";
}
return(R_makeEnumValue(val, elName, "StrongScriptDirection"));
}

#endif
