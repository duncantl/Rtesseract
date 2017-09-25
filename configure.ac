AC_INIT(src/ext.cpp)

# find leptonica, tesseract

# determine what image formats leptonica supports

AC_PATH_PROG(PKG_CONFIG, pkg-config, [echo "Cannot find pkg-config"])

if ! test "$PKG_CONFIG" = "" ; then

LEPT_CFLAGS=`${PKG_CONFIG} --cflags lept`

if ! test "$?" = "0" ; then
  echo "Failed to get compilation flags for leptonica via pkg-config"
  echo "LEPT_CFLAGS = $LEPT_CFLAGS"
fi

LEPT_LIBS=`$PKG_CONFIG --libs lept`

TESS_CFLAGS=`${PKG_CONFIG} --cflags tesseract`
TESS_LIBS=`${PKG_CONFIG} --libs tesseract`

fi

dnl probably should use the one from R's configuration
dnl  CXX=`R CMD config  CXX`
AC_PROG_CXX


CXXFLAGS="$TESS_CFLAGS $CXXFLAGS"
echo "$TESS_CFLAGS"
AC_LANG(C++)

AC_TRY_COMPILE(
 [
   #include <string>
   using std::string; 
   #include <baseapi.h> 
 ],
 [
    tesseract::TessBaseAPI api;
    api.GetInputName();
 ],
 [CPPDEFS="$CPPDEFS -DHAS_GETINPUT_NAME=1"],
 [echo "No GetInputName() method for the TessBaseAPI"]
 )


AC_TRY_COMPILE(
 [
   #include <string>
   using std::string; 
   #include <baseapi.h> 
 ],
 [
    tesseract::TessBaseAPI * api;
    api->GetDatapath();
 ],
 [CPPDEFS="$CPPDEFS -DHAS_GETDATAPATH=1"],
 [echo "No GetDatapath() method for the TessBaseAPI"]
 )

AC_TRY_COMPILE(
 [
  #include <string>
  using std::string; 
  #include <baseapi.h> 
 ],
 [
    tesseract::TessBaseAPI * api;
    api->GetSourceYResolution();
 ],
 [CPPDEFS="$CPPDEFS -DHAS_GETSOURCEYRESOLUTION=1"],
 [echo "No GetSourceYResolution() method for the TessBaseAPI"]
 )



AC_TRY_COMPILE(
 [
   #include <string>
   using std::string;
   #include <tesseract/baseapi.h>
   #include <tesseract/renderer.h>
 ],
 [
    tesseract::TessPDFRenderer render("", "", true);
 ],
 [CPPDEFS="$CPPDEFS -DPDF_RENDER_HAS_TEXT_ONLY=1"; echo "Has textonly parameter"],
 [echo "TessPDFRender constructor has no textonly parameter"]
)


AC_TRY_COMPILE(
 [
   #include <string>
   using std::string;
   #include <tesseract/baseapi.h>
 ],
 [
    tesseract::DetectOrientationScript;
 ],
 [CPPDEFS="$CPPDEFS -DHAS_DETECT_ORIENTATION_SCRIPT=1"; echo "Has DetectOrientatinScript() method"],
 [echo "NO DetectOrientationScript() method"]
)




PNG_FILES="NA"
JPG_FILES="NA"
TIFF_FILES="NA"

echo "Compiling readImage"
$CXX $CPPFLAGS $CXXFLAGS -o readImage readImg.cpp $TESS_CFLAGS $LEPT_CFLAGS  $TESS_LIBS $LEPT_LIBS

if test "$?" = "0" ; then
  echo "testing leptonica can read different image formats"
  JPG_FILES="FALSE"
  ./readImage inst/images/IMG_1236.jpg
  if test $? -eq 0 ; then
    echo "jpg support"
    JPG_FILES="TRUE"
  fi
  TIFF_FILES="FALSE"
  ./readImage inst/images/OCRSample.tiff
  if test $? -eq 0 ; then
    echo "tiff support"
    TIFF_FILES="TRUE"
  fi
  PNG_FILES="FALSE"
  ./readImage inst/images/DifferentFonts.png
  if test $? -eq 0 ; then
    echo "png support"
    PNG_FILES="TRUE"
  fi
else
  echo "Failed to create readImage.  Problems with compilation and/or linking."
fi






AC_SUBST(CPPDEFS)

AC_SUBST(LEPT_LIBS)
AC_SUBST(LEPT_CFLAGS)
AC_SUBST(TESS_CFLAGS)
AC_SUBST(TESS_LIBS)


AC_SUBST(PNG_FILES)
AC_SUBST(JPG_FILES)
AC_SUBST(TIFF_FILES)

TESSERACT_VERSION=`$PKG_CONFIG --modversion tesseract`
LEPTONICA_VERSION=`$PKG_CONFIG --modversion lept`

echo "Tesseract version: $TESSERACT_VERSION"
echo "Leptonica version: $LEPTONICA_VERSION"

AC_SUBST(TESSERACT_VERSION)
AC_SUBST(LEPTONICA_VERSION)

USE_REXIT="FALSE"

echo "R_INCLUDE_DIR:  $R_INCLUDE_DIR"

echo "Building libRexit.a"
(cd src/Rexit; make)
if test $? = 0 ; then
AC_OUTPUT(testRexit/Makevars)

echo "Compiling testRexit/tmp.so"
(cd testRexit; R CMD SHLIB -o tmp.so main.cc)

echo "Checking testRexit/tmp.so"
STR=`Rscript -e 'dyn.load("testRexit/tmp.so"); .C("R_check")' 2>&1 | grep '<tesseract>'`
echo "output: $STR"
if test -n "$STR" ; then
  USE_REXIT="TRUE"
  REXIT_LIB="-LRexit -lRexit"
  echo "Using libRexit mechanism"
else
   echo "libRexit didn't seem to work. Using atexit() mechanism"
fi
else
  echo "Could not build src/Rexit/libRexit.a.  Using atexit() mechanism"
fi  # end of test for building libRexit.a

AC_SUBST(USE_REXIT)
AC_SUBST(REXIT_LIB)

AC_OUTPUT(src/Makevars R/imageCapabilities.R R/config.R)
