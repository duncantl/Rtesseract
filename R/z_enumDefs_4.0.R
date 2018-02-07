if(tesseractVersion(runTime = FALSE) %in% c('4.00')) {
    
setClass("PolyBlockType", contains = "EnumValue")

PolyBlockType = PolyBlockTypeValues = structure(c(0L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 11L, 12L, 13L, 14L, 15L), .Names = c('PT_UNKNOWN', 'PT_FLOWING_TEXT', 'PT_HEADING_TEXT', 'PT_PULLOUT_TEXT', 'PT_EQUATION', 'PT_INLINE_EQUATION', 'PT_TABLE', 'PT_VERTICAL_TEXT', 'PT_CAPTION_TEXT', 'PT_FLOWING_IMAGE', 'PT_HEADING_IMAGE', 'PT_PULLOUT_IMAGE', 'PT_HORZ_LINE', 'PT_VERT_LINE', 'PT_NOISE', 'PT_COUNT'))

`PT_UNKNOWN` = GenericEnumValue('PT_UNKNOWN', 0L, 'PolyBlockType')
`PT_FLOWING_TEXT` = GenericEnumValue('PT_FLOWING_TEXT', 1L, 'PolyBlockType')
`PT_HEADING_TEXT` = GenericEnumValue('PT_HEADING_TEXT', 2L, 'PolyBlockType')
`PT_PULLOUT_TEXT` = GenericEnumValue('PT_PULLOUT_TEXT', 3L, 'PolyBlockType')
`PT_EQUATION` = GenericEnumValue('PT_EQUATION', 4L, 'PolyBlockType')
`PT_INLINE_EQUATION` = GenericEnumValue('PT_INLINE_EQUATION', 5L, 'PolyBlockType')
`PT_TABLE` = GenericEnumValue('PT_TABLE', 6L, 'PolyBlockType')
`PT_VERTICAL_TEXT` = GenericEnumValue('PT_VERTICAL_TEXT', 7L, 'PolyBlockType')
`PT_CAPTION_TEXT` = GenericEnumValue('PT_CAPTION_TEXT', 8L, 'PolyBlockType')
`PT_FLOWING_IMAGE` = GenericEnumValue('PT_FLOWING_IMAGE', 9L, 'PolyBlockType')
`PT_HEADING_IMAGE` = GenericEnumValue('PT_HEADING_IMAGE', 10L, 'PolyBlockType')
`PT_PULLOUT_IMAGE` = GenericEnumValue('PT_PULLOUT_IMAGE', 11L, 'PolyBlockType')
`PT_HORZ_LINE` = GenericEnumValue('PT_HORZ_LINE', 12L, 'PolyBlockType')
`PT_VERT_LINE` = GenericEnumValue('PT_VERT_LINE', 13L, 'PolyBlockType')
`PT_NOISE` = GenericEnumValue('PT_NOISE', 14L, 'PolyBlockType')
`PT_COUNT` = GenericEnumValue('PT_COUNT', 15L, 'PolyBlockType')

 setAs("character", "PolyBlockType", function(from) asEnumValue(from, PolyBlockTypeValues, "PolyBlockType", prefix = "PT_") )
 setAs("integer", "PolyBlockType", function(from) asEnumValue(from, PolyBlockTypeValues, "PolyBlockType", prefix = NA) )
 setAs("numeric", "PolyBlockType", function(from) asEnumValue(from, PolyBlockTypeValues, "PolyBlockType", prefix = NA) )
setClass("Orientation", contains = "EnumValue")

Orientation = OrientationValues = structure(c(0L, 1L, 2L, 3L), .Names = c('ORIENTATION_PAGE_UP', 'ORIENTATION_PAGE_RIGHT', 'ORIENTATION_PAGE_DOWN', 'ORIENTATION_PAGE_LEFT'))

`ORIENTATION_PAGE_UP` = GenericEnumValue('ORIENTATION_PAGE_UP', 0L, 'Orientation')
`ORIENTATION_PAGE_RIGHT` = GenericEnumValue('ORIENTATION_PAGE_RIGHT', 1L, 'Orientation')
`ORIENTATION_PAGE_DOWN` = GenericEnumValue('ORIENTATION_PAGE_DOWN', 2L, 'Orientation')
`ORIENTATION_PAGE_LEFT` = GenericEnumValue('ORIENTATION_PAGE_LEFT', 3L, 'Orientation')

 setAs("character", "Orientation", function(from) asEnumValue(from, OrientationValues, "Orientation", prefix = "ORIENTATION_") )
 setAs("integer", "Orientation", function(from) asEnumValue(from, OrientationValues, "Orientation", prefix = NA) )
 setAs("numeric", "Orientation", function(from) asEnumValue(from, OrientationValues, "Orientation", prefix = NA) )
setClass("WritingDirection", contains = "EnumValue")

WritingDirection = WritingDirectionValues = structure(c(0L, 1L, 2L), .Names = c('WRITING_DIRECTION_LEFT_TO_RIGHT', 'WRITING_DIRECTION_RIGHT_TO_LEFT', 'WRITING_DIRECTION_TOP_TO_BOTTOM'))

`WRITING_DIRECTION_LEFT_TO_RIGHT` = GenericEnumValue('WRITING_DIRECTION_LEFT_TO_RIGHT', 0L, 'WritingDirection')
`WRITING_DIRECTION_RIGHT_TO_LEFT` = GenericEnumValue('WRITING_DIRECTION_RIGHT_TO_LEFT', 1L, 'WritingDirection')
`WRITING_DIRECTION_TOP_TO_BOTTOM` = GenericEnumValue('WRITING_DIRECTION_TOP_TO_BOTTOM', 2L, 'WritingDirection')

 setAs("character", "WritingDirection", function(from) asEnumValue(from, WritingDirectionValues, "WritingDirection", prefix ="WRITING_DIRECTION_") )
 setAs("integer", "WritingDirection", function(from) asEnumValue(from, WritingDirectionValues, "WritingDirection", prefix = NA) )
 setAs("numeric", "WritingDirection", function(from) asEnumValue(from, WritingDirectionValues, "WritingDirection", prefix = NA) )
setClass("TextlineOrder", contains = "EnumValue")

TextlineOrder = TextlineOrderValues = structure(c(0L, 1L, 2L), .Names = c('TEXTLINE_ORDER_LEFT_TO_RIGHT', 'TEXTLINE_ORDER_RIGHT_TO_LEFT', 'TEXTLINE_ORDER_TOP_TO_BOTTOM'))

`TEXTLINE_ORDER_LEFT_TO_RIGHT` = GenericEnumValue('TEXTLINE_ORDER_LEFT_TO_RIGHT', 0L, 'TextlineOrder')
`TEXTLINE_ORDER_RIGHT_TO_LEFT` = GenericEnumValue('TEXTLINE_ORDER_RIGHT_TO_LEFT', 1L, 'TextlineOrder')
`TEXTLINE_ORDER_TOP_TO_BOTTOM` = GenericEnumValue('TEXTLINE_ORDER_TOP_TO_BOTTOM', 2L, 'TextlineOrder')

 setAs("character", "TextlineOrder", function(from) asEnumValue(from, TextlineOrderValues, "TextlineOrder", prefix = "TEXTLINE_ORDER") )
 setAs("integer", "TextlineOrder", function(from) asEnumValue(from, TextlineOrderValues, "TextlineOrder", prefix = NA) )
 setAs("numeric", "TextlineOrder", function(from) asEnumValue(from, TextlineOrderValues, "TextlineOrder", prefix = NA) )
setClass("PageSegMode", contains = "EnumValue")

PageSegMode = PageSegModeValues = structure(c(0L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 11L, 12L, 13L, 14L), .Names = c('PSM_OSD_ONLY', 'PSM_AUTO_OSD', 'PSM_AUTO_ONLY', 'PSM_AUTO', 'PSM_SINGLE_COLUMN', 'PSM_SINGLE_BLOCK_VERT_TEXT', 'PSM_SINGLE_BLOCK', 'PSM_SINGLE_LINE', 'PSM_SINGLE_WORD', 'PSM_CIRCLE_WORD', 'PSM_SINGLE_CHAR', 'PSM_SPARSE_TEXT', 'PSM_SPARSE_TEXT_OSD', 'PSM_RAW_LINE', 'PSM_COUNT'))

`PSM_OSD_ONLY` = GenericEnumValue('PSM_OSD_ONLY', 0L, 'PageSegMode')
`PSM_AUTO_OSD` = GenericEnumValue('PSM_AUTO_OSD', 1L, 'PageSegMode')
`PSM_AUTO_ONLY` = GenericEnumValue('PSM_AUTO_ONLY', 2L, 'PageSegMode')
`PSM_AUTO` = GenericEnumValue('PSM_AUTO', 3L, 'PageSegMode')
`PSM_SINGLE_COLUMN` = GenericEnumValue('PSM_SINGLE_COLUMN', 4L, 'PageSegMode')
`PSM_SINGLE_BLOCK_VERT_TEXT` = GenericEnumValue('PSM_SINGLE_BLOCK_VERT_TEXT', 5L, 'PageSegMode')
`PSM_SINGLE_BLOCK` = GenericEnumValue('PSM_SINGLE_BLOCK', 6L, 'PageSegMode')
`PSM_SINGLE_LINE` = GenericEnumValue('PSM_SINGLE_LINE', 7L, 'PageSegMode')
`PSM_SINGLE_WORD` = GenericEnumValue('PSM_SINGLE_WORD', 8L, 'PageSegMode')
`PSM_CIRCLE_WORD` = GenericEnumValue('PSM_CIRCLE_WORD', 9L, 'PageSegMode')
`PSM_SINGLE_CHAR` = GenericEnumValue('PSM_SINGLE_CHAR', 10L, 'PageSegMode')
`PSM_SPARSE_TEXT` = GenericEnumValue('PSM_SPARSE_TEXT', 11L, 'PageSegMode')
`PSM_SPARSE_TEXT_OSD` = GenericEnumValue('PSM_SPARSE_TEXT_OSD', 12L, 'PageSegMode')
`PSM_RAW_LINE` = GenericEnumValue('PSM_RAW_LINE', 13L, 'PageSegMode')
`PSM_COUNT` = GenericEnumValue('PSM_COUNT', 14L, 'PageSegMode')

 setAs("character", "PageSegMode", function(from) asEnumValue(from, PageSegModeValues, "PageSegMode", prefix = "PSM_") )
 setAs("integer", "PageSegMode", function(from) asEnumValue(from, PageSegModeValues, "PageSegMode", prefix = NA) )
 setAs("numeric", "PageSegMode", function(from) asEnumValue(from, PageSegModeValues, "PageSegMode", prefix = NA) )
setClass("PageIteratorLevel", contains = "EnumValue")

PageIteratorLevel = PageIteratorLevelValues = structure(c(0L, 1L, 2L, 3L, 4L), .Names = c('RIL_BLOCK', 'RIL_PARA', 'RIL_TEXTLINE', 'RIL_WORD', 'RIL_SYMBOL'))

`RIL_BLOCK` = GenericEnumValue('RIL_BLOCK', 0L, 'PageIteratorLevel')
`RIL_PARA` = GenericEnumValue('RIL_PARA', 1L, 'PageIteratorLevel')
`RIL_TEXTLINE` = GenericEnumValue('RIL_TEXTLINE', 2L, 'PageIteratorLevel')
`RIL_WORD` = GenericEnumValue('RIL_WORD', 3L, 'PageIteratorLevel')
`RIL_SYMBOL` = GenericEnumValue('RIL_SYMBOL', 4L, 'PageIteratorLevel')

 setAs("character", "PageIteratorLevel", function(from) asEnumValue(from, PageIteratorLevelValues, "PageIteratorLevel", prefix = "RIL_") )
 setAs("integer", "PageIteratorLevel", function(from) asEnumValue(from, PageIteratorLevelValues, "PageIteratorLevel", prefix = NA) )
 setAs("numeric", "PageIteratorLevel", function(from) asEnumValue(from, PageIteratorLevelValues, "PageIteratorLevel", prefix = NA) )
setClass("ParagraphJustification", contains = "EnumValue")

ParagraphJustification = ParagraphJustificationValues = structure(c(0L, 1L, 2L, 3L), .Names = c('JUSTIFICATION_UNKNOWN', 'JUSTIFICATION_LEFT', 'JUSTIFICATION_CENTER', 'JUSTIFICATION_RIGHT'))

`JUSTIFICATION_UNKNOWN` = GenericEnumValue('JUSTIFICATION_UNKNOWN', 0L, 'ParagraphJustification')
`JUSTIFICATION_LEFT` = GenericEnumValue('JUSTIFICATION_LEFT', 1L, 'ParagraphJustification')
`JUSTIFICATION_CENTER` = GenericEnumValue('JUSTIFICATION_CENTER', 2L, 'ParagraphJustification')
`JUSTIFICATION_RIGHT` = GenericEnumValue('JUSTIFICATION_RIGHT', 3L, 'ParagraphJustification')

 setAs("character", "ParagraphJustification", function(from) asEnumValue(from, ParagraphJustificationValues, "ParagraphJustification", prefix = "JUSTIFICATION_") )
 setAs("integer", "ParagraphJustification", function(from) asEnumValue(from, ParagraphJustificationValues, "ParagraphJustification", prefix = NA) )
 setAs("numeric", "ParagraphJustification", function(from) asEnumValue(from, ParagraphJustificationValues, "ParagraphJustification", prefix = NA) )
setClass("OcrEngineMode", contains = "EnumValue")

OcrEngineMode = OcrEngineModeValues = structure(c(0L, 1L, 2L, 3L), .Names = c('OEM_TESSERACT_ONLY', 'OEM_CUBE_ONLY', 'OEM_TESSERACT_CUBE_COMBINED', 'OEM_DEFAULT'))

`OEM_TESSERACT_ONLY` = GenericEnumValue('OEM_TESSERACT_ONLY', 0L, 'OcrEngineMode')
`OEM_CUBE_ONLY` = GenericEnumValue('OEM_CUBE_ONLY', 1L, 'OcrEngineMode')
`OEM_TESSERACT_CUBE_COMBINED` = GenericEnumValue('OEM_TESSERACT_CUBE_COMBINED', 2L, 'OcrEngineMode')
`OEM_DEFAULT` = GenericEnumValue('OEM_DEFAULT', 3L, 'OcrEngineMode')

 setAs("character", "OcrEngineMode", function(from) asEnumValue(from, OcrEngineModeValues, "OcrEngineMode", prefix = "OEM_") )
 setAs("integer", "OcrEngineMode", function(from) asEnumValue(from, OcrEngineModeValues, "OcrEngineMode", prefix = NA) )
 setAs("numeric", "OcrEngineMode", function(from) asEnumValue(from, OcrEngineModeValues, "OcrEngineMode", prefix = NA) )
setClass("StrongScriptDirection", contains = "EnumValue")

StrongScriptDirection = StrongScriptDirectionValues = structure(c(0L, 1L, 2L, 3L), .Names = c('DIR_NEUTRAL', 'DIR_LEFT_TO_RIGHT', 'DIR_RIGHT_TO_LEFT', 'DIR_MIX'))

`DIR_NEUTRAL` = GenericEnumValue('DIR_NEUTRAL', 0L, 'StrongScriptDirection')
`DIR_LEFT_TO_RIGHT` = GenericEnumValue('DIR_LEFT_TO_RIGHT', 1L, 'StrongScriptDirection')
`DIR_RIGHT_TO_LEFT` = GenericEnumValue('DIR_RIGHT_TO_LEFT', 2L, 'StrongScriptDirection')
`DIR_MIX` = GenericEnumValue('DIR_MIX', 3L, 'StrongScriptDirection')

 setAs("character", "StrongScriptDirection", function(from) asEnumValue(from, StrongScriptDirectionValues, "StrongScriptDirection", prefix = "DIR_") )
 setAs("integer", "StrongScriptDirection", function(from) asEnumValue(from, StrongScriptDirectionValues, "StrongScriptDirection", prefix = NA) )
 setAs("numeric", "StrongScriptDirection", function(from) asEnumValue(from, StrongScriptDirectionValues, "StrongScriptDirection", prefix = NA) )



}


