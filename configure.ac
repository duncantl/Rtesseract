AC_INIT(src/ext.cpp)

# find leptonica, tesseract

# determine what image formats leptonica supports

AC_PATH_PROG(PKG_CONFIG, pkg-config, [echo "Cannot find pkg-config"])

if ! test "$PKG_CONFIG" = "" ; then

LEPT_CFLAGS=`${PKG_CONFIG} --cflags lept`

if ! test "$?" = "0" ; then
  echo "Failed to get compilation flags for leptonica via pkg-config"
  echo "$LEPT_CFLAGS"
fi

LEPT_LIBS=`$PKG_CONFIG --libs lept`

TESS_CFLAGS=`${PKG_CONFIG} --cflags tesseract`
TESS_LIBS=`${PKG_CONFIG} --libs tesseract`

fi


dnl probably should use the one from R's configuration
dnl  CXX=`R CMD config  CXX`
AC_PROG_CXX


PNG_FILES="NA"
JPG_FILES="NA"
TIFF_FILES="NA"

echo "Compiling readImage"
$CXX -o readImage readImg.cpp $TESS_CFLAGS $LEPT_CFLAGS  $TESS_LIBS $LEPT_LIBS

if test "$?" = "0" ; then
  echo "testing leptonica can read different image formats"
  ./readImage inst/images/IMG_1236.jpg
  JPG_FILES="FALSE"
  if test $? ; then
    echo "jpg support"
    JPG_FILES="TRUE"
  fi
  ./readImage inst/images/OCRSample.tiff
  TIFF_FILES="FALSE"
  if test $? ; then
    echo "tiff support"
    TIFF_FILES="TRUE"
  fi
  ./readImage inst/images/DifferentFonts.png
  PNG_FILES="FALSE"
  if test $? ; then
    echo "png support"
    PNG_FILES="TRUE"
  fi
fi



AC_SUBST(LEPT_LIBS)
AC_SUBST(LEPT_CFLAGS)
AC_SUBST(TESS_CFLAGS)
AC_SUBST(TESS_LIBS)


AC_SUBST(PNG_FILES)
AC_SUBST(JPG_FILES)
AC_SUBST(TIFF_FILES)

AC_OUTPUT(src/Makevars R/imageCapabilities.R)
