AC_INIT(src/ext.cpp)

# find leptonica, tesseract

# determine what image formats leptonica supports

AC_PATH_PROG(PKG_CONFIG, pkg-config, [echo "Cannot find pkg-config"])

if test -n "$PKG_CONFIG" ; then

  LEPT_CFLAGS=`${PKG_CONFIG} --cflags lept`

  if ! test "$?" = "0" ; then
    echo "Failed to get compilation flags for leptonica via pkg-config"
    echo "LEPT_CFLAGS = $LEPT_CFLAGS"
  fi

  LEPT_LIBS=`$PKG_CONFIG --libs lept`

  TESS_CFLAGS=`${PKG_CONFIG} --cflags tesseract`
  TESS_LIBS=`${PKG_CONFIG} --libs tesseract`

fi


dnl For 4.00dev beta, we need -std=c++11. Should check for this in a more structured manner, but for now just bang it in
dnl but allow the user set CXXFLAGS and override this.
if test -z "$CXXFLAGS" ; then
  CXXFLAGS="-std=c++11"
fi



dnl probably should use the one from R's configuration
dnl  CXX=`R CMD config  CXX`
AC_PROG_CXX

echo "CXXFLAGS = $CXXFLAGS"


CXXFLAGS="$TESS_CFLAGS $CXXFLAGS"
echo "Tesseract CFLAGS = $TESS_CFLAGS"

AC_LANG(C++)

AC_TRY_COMPILE(
 [
   #include <baseapi.h> 
 ],
 [
    tesseract::TessBaseAPI api;
 ],
 [CPPDEFS="$CPPDEFS -DHAS_GETINPUT_NAME=1"],
 [ export CXXFLAGS="$CXXFLAGS -DADD_TESSERACT_DIR=1"; export TESS_CFLAGS="$TESS_CFLAGS -DADD_TESSERACT_DIR=1" ; echo "Did not find baseapi.h directly. Need to look for <tesseract/baseapi.h> or add tesseract to include flags $TESS_CFLAGS"]
)




AC_TRY_COMPILE(
 [
   #include <string>
   using std::string;
#ifndef ADD_TESSERACT_DIR
   #include <baseapi.h>
#else
   #include <tesseract/baseapi.h>
#endif
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
#ifndef ADD_TESSERACT_DIR
   #include <baseapi.h>
#else
   #include <tesseract/baseapi.h>
#endif   
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
#ifndef ADD_TESSERACT_DIR
   #include <baseapi.h>
#else
   #include <tesseract/baseapi.h>
#endif
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
#ifndef ADD_TESSERACT_DIR
   #include <baseapi.h>
   #include <renderer.h>   
#else
   #include <tesseract/baseapi.h>
   #include <tesseract/renderer.h>
#endif   
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
#ifndef ADD_TESSERACT_DIR
   #include <baseapi.h>
#else
   #include <tesseract/baseapi.h>
#endif   
 ],
 [
    tesseract::DetectOrientationScript;
 ],
 [CPPDEFS="$CPPDEFS -DHAS_DETECT_ORIENTATION_SCRIPT=1"; echo "Has DetectOrientatinScript() method"],
 [echo "NO DetectOrientationScript() method"]
)


AC_TRY_COMPILE(
 [
#ifndef ADD_TESSERACT_DIR 
   #include <publictypes.h>
#else
   #include <tesseract/publictypes.h> 
#endif
 ],
 [
    tesseract::OEM_LSTM_ONLY;
 ],
 [CPPDEFS="$CPPDEFS -DHAS_OEM_LSTM=1"],
 [echo "No OEM_LSTM_ONLY enumeration value for the TessBaseAPI"]
 )


AC_TRY_COMPILE(
 [
#ifndef ADD_TESSERACT_DIR 
   #include <publictypes.h>
#else
   #include <tesseract/publictypes.h> 
#endif
 ],
 [
    tesseract::OEM_CUBE_ONLY;
 ],
 [CPPDEFS="$CPPDEFS -DHAS_CUBE_ONLY=1"],
 [echo "No OEM_CUBE_ONLY enumeration value for the TessBaseAPI"]
 )


PNG_FILES="NA"
JPG_FILES="NA"
TIFF_FILES="NA"
WEBP_FILES="NA"
JP2_FILES="NA"
PNM_FILES="NA"
GIF_FILES="NA"
BMP_FILES="NA"
PS_FILES="NA"
PDF_FILES="NA"
SPIX_FILES="NA"

echo "Compiling readImage"
dnl echo "$CXX -o readImage readImg.cpp $LEPT_CFLAGS $TESS_CFLAGS $CXXFLAGS $CPPFLAGS  $LEPT_LIBS $TESS_LIBS"
$CXX -o readImage readImg.cpp $LEPT_CFLAGS $TESS_CFLAGS $CXXFLAGS $CPPFLAGS $LEPT_LIBS  $TESS_LIBS

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
  WEBP_FILES="FALSE"
  ./readImage sampleImage.webp
  if test $? -eq 0 ; then
    echo "webp support"
    WEBP_FILES="TRUE"
  fi
  JP2_FILES="FALSE"
  ./readImage sampleImage.jp2
  if test $? -eq 0 ; then
    echo "jp2 support"
    JP2_FILES="TRUE"
  else
    echo "** no jp2 suppport"
  fi
  GIF_FILES="FALSE"
  ./readImage sampleImage.gif
  if test $? -eq 0 ; then
    echo "gif support"
    GIF_FILES="TRUE"
  fi  
  BMP_FILES="FALSE"
  ./readImage sampleImage.bmp
  if test $? -eq 0 ; then
    echo "bmp support"
    BMP_FILES="TRUE"
  fi
  PNM_FILES="FALSE"
  ./readImage sampleImage.pnm
  if test $? -eq 0 ; then
    echo "pnm support"
    PNM_FILES="TRUE"
  fi
  PS_FILES="FALSE"
  ./readImage sampleImage.ps
  if test $? -eq 0 ; then
    echo "ps support"
    PS_FILES="TRUE"
  fi
  SPIX_FILES="FALSE"
  ./readImage sampleImage.spix
  if test $? -eq 0 ; then
    echo "spix support"
    SPIX_FILES="TRUE"
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
AC_SUBST(WEBP_FILES)
AC_SUBST(JP2_FILES)
AC_SUBST(PNM_FILES)
AC_SUBST(BMP_FILES)
AC_SUBST(GIF_FILES)
AC_SUBST(PS_FILES)
AC_SUBST(SPIX_FILES)

TESSERACT_VERSION=`$PKG_CONFIG --modversion tesseract`
LEPTONICA_VERSION=`$PKG_CONFIG --modversion lept`

echo "Tesseract version: $TESSERACT_VERSION"
echo "Leptonica version: $LEPTONICA_VERSION"

AC_SUBST(TESSERACT_VERSION)
AC_SUBST(LEPTONICA_VERSION)

USE_REXIT="FALSE"

echo "R_INCLUDE_DIR:  $R_INCLUDE_DIR"

if test -n "" ; then 

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

fi


AC_SUBST(USE_REXIT)
AC_SUBST(REXIT_LIB)

AC_OUTPUT(src/Makevars R/imageCapabilities.R R/config.R)
