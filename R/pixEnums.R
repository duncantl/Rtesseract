ImageFormatValues = PixFormatValues =
c(  IFF_UNKNOWN        = 0,
    IFF_BMP            = 1,
    IFF_JFIF_JPEG      = 2,
    IFF_PNG            = 3,
    IFF_TIFF           = 4,
    IFF_TIFF_PACKBITS  = 5,
    IFF_TIFF_RLE       = 6,
    IFF_TIFF_G3        = 7,
    IFF_TIFF_G4        = 8,
    IFF_TIFF_LZW       = 9,
    IFF_TIFF_ZIP       = 10,
    IFF_PNM            = 11,
    IFF_PS             = 12,
    IFF_GIF            = 13,
    IFF_JP2            = 14,
    IFF_WEBP           = 15,
    IFF_LPDF           = 16,
    IFF_TIFF_JPEG      = 17,
    IFF_DEFAULT        = 18,
    IFF_SPIX           = 19)


setClass("ImageFormat", contains = "EnumValue")

 setAs("character", "ImageFormat", function(from) asEnumValue(from, ImageFormatValues, "ImageFormat", prefix = "IFF_") )
 setAs("integer", "ImageFormat", function(from) asEnumValue(from, ImageFormatValues, "ImageFormat", prefix = NA) )
 setAs("numeric", "ImageFormat", function(from) asEnumValue(from, ImageFormatValues, "ImageFormat", prefix = NA) )
