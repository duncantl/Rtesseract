# Todo Items

## New Features

1. [implemented] LRTResultIterator to get font informationitalics, etc.
     + Results don't seem interesting. See if it works in tesseract 3.05

1. Add functionality to find columns. To extract tabular data.

1. Allow plotSubImage() to work from the Pix rather than requiring png::readPNG() or equivalent.
   + Will accept a pix but problems with values of cells if not thresholded. See tests/subImage.R

1. Speed up conversion of Pix to R ??
   + Is this a bottleneck. Profile it.

## Important
1. Should pix[r, c, ] get the RGB.
    + and pix[,,] give an array.

1. Get color of a pixel

1. How to access the preprocessed images before the OCR is actually done, i.e. after the
   preprocessing Tesseract and Leptonica perform ?  
    + GetThresholdedImage().
	+ What about the rotation/deskew? Can we recover the amount it was rotated?

1. *** In plot.OCR, use red-green color map/scale. Deal with color-blind issues.
    + [DOCUMENT] allow user to specify the end points of the color ramp via an option OCRConfidenceColors with 
	   two values - low and high.

1. In plot.OCR, add a legend.

1. [mostly done] Make getLines() more robust.
    + Not sure what else to check other than A LOT OF EXAMPLES!
    + verify results from findLines() and getLines() functions.	
	  + The UCD_Lehmann_0377.jpg one doesn't give good results.

1. What are the names of the init variables,  versus the non-init variables.
   And what are the ones we set in config and vars

1. [fixed but needs more investigation] Are variables being set? in the Init()?
See the textord_tabfind_show_vlines
```
library(Rtesseract);smithburn = system.file("images", "SMITHBURN_1952_p3.png", package = "Rtesseract")          
ts = tesseract(smithburn, pageSegMode = "psm_auto", textord_tabfind_show_vlines = 1)
GetVariables(ts, "textord_tabfind_show_vlines") # FALSE
SetVariables(ts, textord_tabfind_show_vlines = 1)
GetVariables(ts, "textord_tabfind_show_vlines") # TRUE
```
  Seem to call SetVariables() before Init().
  I changed this in Oct 2018. Reverted it now so the above actually works.

1. [finalize fixes] Add showPoints() like the one in ReadPDF.
    + There is a function in OCRResults.R
	+ Added guidelines within the circle
	   + but they don't connect to circle contour. Most likely aspect ratio issues. (Works for 0 and 180 degrees.)

1. SVG view. - mkSVG() and mkSVG2()
    + Scale properly.
	+ [already done] Use colors from GetConfidenceColors ??
    + Annotate an SVG plot of this so that we can see the confidence levels and alternatives for a bbox.	
	+ [done] mkSVG2(): Show the image underneath and then the boxes and allow the viewer to see the "truth" and
      what was recognized via a tooltip.  

1. user dictionary option. See inst/Paper/dictTest.R
   
1. [ok, but explore tesseract 4 lstm setting] Does IsValidWord() actually work? Seems to always say FALSE???
   + If we use OEM_TESSERACT_ONLY as the engineMode in the call to tesseract(), then this does work.
     But not with the default engineMode - OEM_DEFAULT.

1. [see inst/bin/pdf2png] Rewrite the script that converts a scanned PDF document with multiple pages to 
 a series of independent files each containing a page. (Lost on my previous laptop.)
    + Consider renaming pdf2images
 
1. Check the character encoding under the following setup:
     + [Done] do OCR on a foreign page with words that have accents or different characters
	   + see RussianDoc.png, French.png and Sanscrit.png
	 + use a different language setting for TESSDATA_PREFIX

1. Test under a different locale.

1. Clean up top-level dir
  - sampleImage.*: required to set image capabilities
  - R scripts: createSamplePNG.R, lines.R, lines2.R
  - directories: testRexit TU
  - cpp: readImage.cpp
  - notes: Note findLines_notes

1. [pixRotate done] Add general pixRotate() functions, not just pixRotateAMGray().
   + [TODO] e.g. pixRotate(), pixRotateOrth(), pixRotateAMColor(), pixRotateShear/Center
     + Not needed -  pixRotate{90,180},

1. Memory Leak notifications when quit from R.
   If we rm() any api object and then explicitly gc(), no problem. W/o the gc(), we get the
   ObjectCache warnings. These are relatively deep down in tesseract.
   How important is this.
    If it is, we can collect all the tesseract objects in a linked list within the package
	and remove them when they are freed. Then, when the package is detached, any API objects left in
   the list can be removed and freed.
    + The package is not unloaded or detached except via a user-level .Last, not in the package's code.
   
1. See if we can trap tprintf() calls in tesseract and redirect to R console.
   + On linux with DSOs for libtesseract, we can slide ours in. See ext.cpp.
      Doesn't work so readily on OSX. We'll need to figure out how to override the symbol.
   + Problem is we get several sequential messages which really are part of the same message, so hard
      to collect them into a warning.
      + [implemented] We could use our own .Call() which sets a flag, cumulates the tprintf()s, reports them at the end
          and clears the collection.

1. Catch errors due to wrong version of tessdata, i.e. using 3.0 data with 4.0 tesseract and vice versa.

1. detect and deal with the "dev" string in the tesseract version if that is being used, e.g. tesseractVersion()

1. [works] plot.OCR that takes a Pix as the value if img, or uses the Pix rather than the external file.
   If GetInputName() returns an empty file, then we need to use the Pix directly as it didn't come
   from a file.
   Calling as.raster, so need to provide S3 method for that for pix.
   This arises when we manipulate the image so it is different from the contents in the original
   file, e.g., when we remove lines.

1. [ok] Does plot.OCR call Recognize() again? No
   rasterImage() takes time, calling rgb() which profiling indicates takes the longest time - 27%
   Apparently (when stepping through the code) GetInputName(), is.na(img) before rasterImage() call take time.

1. [improved] Add "[" for Pix
    + Implement RGB.
	+ logical, numeric and matrix
	+ Fast versions now implemented, except for matrix.
    + [no longer true for most cases.] For now, Implementations using pixGetPixels(), so they do not take advantage of efficencies in wanting less than the full matrix. 

1. [low] remove dependencies on readPNG() from plot.OCR()
    Not necessary. They are just suggests. May be faster than plotting from the Pix??

1. Methods for pixOrientDetect, pixUpDownDetect, pixUpDownDetectGeneral

1. [test] pixZero
1. [low] pixWrite() & guessImageFormatByExt(): Maps tiff to tiff_lzw. May want to do better.
1. [low] pixOpenBrick()  or do we implement pixOpenGeneral()??
1. [low] pixConnComp - need?
1. [low] pixSeedfill

1. [test] pixOr, pixAnd, pixXor, 

1. get rid of "libpng warning iCCP: known incorrect sRGB profile"
     This is due to content in the PNG file. 
   + To remove it, one can use ImageMagick's mogrifgy  command-line too.  (Or pngcrush apparently.)
     +  (See https://stackoverflow.com/questions/22745076/libpng-warning-iccp-known-incorrect-srgb-profile)


## A. Required to get package on CRAN

1. Fix some new errors.

1. Update documentation/NAMESPACE to reflect current functions and functionality.
    1.  [passes R CMD check now but needs additions to make it more informative] Documentation
    1.  [make corrections @mespe] Need to do document  @titles in plotSubsets
	1.  [not exported] GetImage’ ‘GetRegions’ ‘GetStrips’
	1.  [Removed] [,EnumDef,ANY-method
	1.  [Removed]  coerce,AsIs,OcrEngineMode-method. It was a way to be able to overcome
	    the missing enums for 4.0

1. Reduce the sizes of the directories in inst/

1. Document build issues for tesseract 4.0 on different platforms.
   In InstallingTesseract.md
   This is not necessarily essential to getting the package on CRAN. As long as it builds on their
   systems (not plural).
	
1. [done] Get this working on Windows.  
    Works for 3.05.01 with Jeroen's build.

1.  Build on windows with tess4.

1.  Windows: And substitute exit() and tprintf() definitions there.
    And leptonica's  output to console.

1. [Check carefully on different plaforms] tprintf() and messages on console.
   <br/>
   See experiments on dsi machine in `LinkExpt/`.
   <br/>
   If using g++ and on Linux, we can get the linking to work using libRexit.a at least for a
   stand-alone application.  Have to check when load into R.
   <br/>
   Appears tprinf_internal() doesn't work on Linux/g++ with a shared library (libRexit.so), but
   exit() does.

<hr/>

### Check/Confirm

1. [does not segfault] Add tests in the R code for tesseract 4.0 that does not support CUBE engine mode in order to avoid segfaulting.
   1.  Do this in Init()
   1.  [Check]! This should be implicit when we add the enums for 4.0 as the coercion to that value will fail.

1. [check] ReadConfigFile(api, "tests/debug_config") terminates if the file has errors.
   try sliding in definition of exit() in Rexit/exit.c
   ```r
   library(Rtesseract); api = tesseract(); ReadConfigFile(api, "Experiments/bad_config")
   ```
   LD_PRELOAD works. But not practical (needs to be specified before starting R). <br/>
   <b>I've implemented a mechanism to avoid exit()ing the process. However, it relies on something
   (atexit with a longjmp) that has undefined behavior in the POSIX specification. However, it
   works.
   Really want to either change the tesseract library or get the linkking to slide a new version of exit.</b>
   
1. [Probably not vital] Reporting of memory leaks at the end of the R session.
   Need to force the garbage collection of the R tesseract objects before the actual exit.
   ```
   library(Rtesseract); tesseract();  gc(); gc(); q("no")
    ```
	Need 2 gc() calls.

1. [verify] Enums for tesseract 4.0. 
    May need to build separate files for 4.00.00 and 4.00.00alpha within the git repos.
    See TU/tu.R for the code.
  
1. [confirmed] Confirm GetBoxes returns what BoundingBoxes used to.

1. [Mostly done]   Color code the rectangles for the bboxes according
   to the confidence. ME - add legend for colors [done].

1. [done] Compute prefix for enums in TU/tu.R.  In RCodeGen::makeEnumClass

1. [done] Make ~ expand for datapath.  Also allow relative paths by completing them, i.e making them full
   ```r
   a = tesseract("DifferentFonts.png",  datapath = "~/OCR/tessdata")
   ```
   See [tests/datapath.R](`tests/datapath.R`)
1. [done] When fail to recognize the value of an enum, fail rather than return 0.

1. [fixed] 2 examples/tests now fail in R CMD check. Due to raiseEnumError() now throwing an error.
    GetText and tests/1990.R.
	It is GetBoxes(, "word"). We are not recognizing the prefix RIL_.
	If we manually add that to the setAs() method for  setAs("character", "PageIteratorLevel",..
    it works.  So we need to compute the prefix in the TU/tu.R code. Look at RCodeGen (and other
    "original" code)

## B. Required to submit paper (assumes all A resolved)

1. [finish up] Get line information.
   Via leptonica, opencv, imager, ...
   <br/>
   I think this is more important than smudges as we know it is vital for tables.
	
1. Work up one example for each major aspect/function in package:
 - remove the highlight
 - Location on page
 - Augment dictionary/patterns
 - access confidences/alternatives, treat as data.
 - subset/"zoom" within R
 - Set variables - fully customize all 680+ variables through API- 
   ??? IN WHAT SENSE "fully customize"

## C. Nice to haves (not strictly needed for A or B)

1. Example for GetSmudges

1. Be able to interrupt in OCR computations with Ctrl-c.

1. [working/finish] Get Pix from tesseract as R array
   GetInputImage() - figure out how to convert the Pix to an array() in R 
     deal with the bits and mapping them back to what we expect from, e.g., readPNG(),
     [fixed] an array is returning 32 deep, whereas readPNG() is just 4.  The depth is in bits in Pix (leptonica).
     Get rid of code that does this the wrong way.
	 
1. [implement with pixSetPixels()] Set Pix from R array to tesseract.

1. [somewhat implemented] Get components - leptonica objects Boxa and Pixa
   <br/>
   See GetRegions(), GetStrips() to et the Boxa and Pixa. Not exported yet. 
   <br/>
   How about identifying lines.  Done in bounding box if we use psm_auto for PageSegmentationMode

## Misc

1. Reference counts for Pix.

1. [Verify sane] Get alternatives is returning different output between:
 ```r
 library(Rtesseract)
 f = system.file("images", "OCRSample2.png", package = "Rtesseract")
 a = getAlternatives(f)

 api = tesseract(f)
 Recognize(api)
 ri = as(api, "ResultIterator")
 b = lapply(ri, getAlternatives, "word")
 identical(a, b)

 api = tesseract(f)
 Recognize(api)
 ri = as(api, "ResultIterator")
 b = lapply(ri, getNativeSymbolInfo("getAlts"), "word")
 ```

1. Do we need to delete the choice object

1. Test that plot/other helper functions are still functioning with output from the getXXX functions.
Fix the names on the bounding boxes to be consistent within the package and with the PDF tables code.
Clean up ocr() so that the bounding box is returned, is consistent with that from BoundingBoxes
 and creates a data frame/matrix.

1. ? Other methods form the baseapi.h ?

1. [can we reproduce this] seg fault in plotSubImage() when run via the examples.
  [Seems okay on OSX machine (DTL)]
  Could be an earlier example with memory issues appearing at this point.
  e.g. pixRead()

1. [check] Rationalize tesseract() and Init() so can pass all the arguments through to Init()

1. [test] Have an option for SetInputName() to read the image and load it via SetImage().

1. [change name of function] How can we query whether we have to call Recognize() or not?
              hasRecognized() function - Change name
                 Ask for a ResultIterator and if it returns NULL, then call Recognize().

1. [very low priority] Sort out the R renderer class.
  Why do we want to have our own?  If we have to use ProcessPages() we don't want to write to disk unnecessarily.


1. [don't make it accessible from the tesseract object]
  When we return a Pix, increase the reference count and put a finalizer to decrease it.
    The destroyPix  seems to be there.

1. [dont expose it to end-user] Also if we have a ResultIterator, don't let the tesseract instance die/
 ?Should we introduce  a sub-class of tesseract with which we can solve these and the already Recognize()d issues?

1. When tesseract complains below, raise an error.  Stop the output going to stdout/stderr<br/>
 (see tprintf_internal issue above. )<br/>
      The error messages run through tprintf_internal() in ccutil/tprinf.cpp.<br/>
      There is a debug_file that we can write to.  Set this and then read that file when there is an error. Very ugly.<br/>
      How do people do this in python, etc.<br/>
  Error opening data file /Users/duncan/Projects/OCR/tesseract-ocr/tessdata/osd.traineddata<br/>
  Please make sure the TESSDATA_PREFIX environment variable is set to the parent directory of your "tessdata" directory.<br/>
  Failed loading language 'osd'<br/>
  Tesseract couldn't load any languages!

1. How do we regenerate this?<br/>
   Unset TESSDATA_PREFIX in ~/.cshrc and run Rtesseract.
 ```r
    api = tesseract("inst/trainingSample/eng.tables.exp0.png", 0L)
 ```
  <br/> This is what did it - but not anymore.
 ```r
   Sys.setenv(TESSDATA_PREFIX= path.expand("~/Projects/OCR/tesseract-ocr"))
   library(Rtesseract)
   api = tesseract("inst/trainingSample/eng.tables.exp0.png", 0L)
   Recognize(api)
 ```


1. Connect to OpenCV for manipulating the image.  perhaps thresholding away the specs. 
    https://github.com/swarm-lab/videoplayR
    https://code.google.com/archive/p/r-opencv/source/default/source


1. ?? GetInputName seems to take an age (in some cases)!!  Did time it and got exactly 0.

1. ?? plot.OCR() seems to be doing something unnecessary - an extra call to Recognize() somewhere?
   Seems okay.  rasterImage() and readPNG() do take time.

1. [not really relevant] See MutableIterator for possibly modifying the tesseract content.
  This is just a live ResultIterator that has access to the contents of the TessBaseAPI so we could change them.

1. [okay now] Can't seem to open pdf config file - i.e., the one called pdf in /usr/local/share/tessdata/configs, but can find batch.nochop.

1. [check] 
 With cropBoxes, can get negative indices.
  Change the margin.  Compute it so that it can't yield negative indices.


1. compareWords() warns about different lengths. Something wrong? See MarkLundy/ocr.R
  Is this to be expected as the ocr and truth words may have different number of characters.
  Or think of other ways to compare them - adist?

1. [check] ocr() function using the API-level functions.
 ACTUALLY, just remove and use getAlternatives(), getConfidences(), getBoxes(), getText().
   i.e. implement not in C but in R code to assemble the different pieces.
   Can do now.

1. [Feature Request] When find an error in the OCR, get the subset of the image for that bounding box and 
   then see if we can cluster them.
    Need to know if it is an error, so presumably need to know truth.
    Or instead of errors, just those values with low confidence.
    See inst/caseStudies

  Can do this from the bounding box information and reading the image using one of the R packages.

1. [ok] error rates and confusion matrix when know the actual values.


1. [Check] Get alternatives via R interface to API, not the R_tesseract_ alternatives routine.
   Is this in the ocr() routine? e.g. ocr(, alternatives = TRUE)



# Other

+ Session generating error about not being able to read osd.traineddata.

 ```r
16> api = tesseract("inst/trainingSample/eng.tables.exp0.png")
17> .Call("R_TessBaseAPI_SetPageSegMode", api, 0L)
[1] TRUE
19> Recognize(api)
Error opening data file /Users/duncan/Projects/OCR/tesseract-ocr/tessdata/osd.traineddata
Please make sure the TESSDATA_PREFIX environment variable is set to the parent directory of your "tessdata" directory.
Failed loading language 'osd'
Tesseract couldn't load any languages!
Warning: Auto orientation and script detection requested, but osd language failed to load
[1] TRUE
20> .Call("R_TessBaseAPI_SetPageSegMode", api, 1L)
[1] TRUE
21> Recognize(api)
Error opening data file /Users/duncan/Projects/OCR/tesseract-ocr/tessdata/osd.traineddata
Please make sure the TESSDATA_PREFIX environment variable is set to the parent directory of your "tessdata" directory.
Failed loading language 'osd'
Tesseract couldn't load any languages!
Warning: Auto orientation and script detection requested, but osd language failed to load
[1] TRUE
22> .Call("R_TessBaseAPI_SetPageSegMode", api, 2L)
[1] TRUE
```

## Tesseract Bugs

1. [tesseract bug] Seg fault
  + Running in inst/images/
```
  library(Rtesseract)
  a = tesseract("SMITHBURN_1952_p3.png", configs = "config")
  Recognize(a)
```
  + If we remove the configs = config, this doesn't segfault.
    So looks like a tesseract issue, but something we need to deal with.
	+ Remove `tessedit_timing_debug 1` from config and it works in R.
	  + But why does it work in stand-alone tesseract with this option.
	  + The error occurrs in 
```
    tprintf("%s (ocr took %.2f sec)\n",
-> 1409	            word->best_choice->unichar_string().string(),
   1410	            static_cast<double>(ocr_t-start_t)/CLOCKS_PER_SEC);
```


## DONE

1. [mostly fixed] In plot.OCR - fillBoxes doesn't seem to do the right thing. Only shows boxes below the table in
   smithburn image.  
   + Is it that it puts a box covering the entire plotting region!!! Yes.
      + This is the word Uganda that has a box that is the entire image.
	  + And several others. These are the words that are under the yellow highlighted text.
   	     + The boxes for these are very large.
   + [DONE] Draw in reverse order of area of each box so the big ones go at the back

1. [solved] In the following code, we don't generate the vhlinefinding.pdf file:
  + Answer: Need pageSegMode = PSM_AUTO
```
  library(Rtesseract)
  a = tesseract("SMITHBURN_1952_p3.png", configs = "config1")
  Recognize(a)
```
   but the stand-alone tesseract does.
   + The stand-alone run also generates a lot more output.
   
1. [fixed] Options
```
a = tesseract( opts = list(tessedit_char_whitelist = letters[1:3]))
```
    + Move the SetVariables call in tesseract() to after the Init()
	
1. [done/okay] pixWrite should guess the format from the extension.	
    Can guess png, webp, jp2, jpeg, jpg, lpdf
	
1. [done] Class and methods for drawing the lines returned by getLines().
   + See tests/lineSegments.R for an example.
   + Take code from paper.
   
1. [done] See if tesseract can read a multi-page document. Has to be in TIFF? PNG? ..., not PDF.
   + Yes. See readMultipageTiff() function. Get back a list of the Pix object for each of the pages.
   + Also added readPixHeader/readImageInfo to get the format information from each image.

1. [fixed] getLines() for UCD_Lehmann_0377.jpg fails. Error occurs.
```
'/Users/duncan/Data/Lehmann_catalogs/UCD_Lehman JPEGs/UCD_Lehmann_0377.jpg'
#f = "inst/images/SMITHBURN_1952_p3.png"
library(Rtesseract)
f = '../UCD_Lehmann_0377.jpg'
ll = findLines(f, 201, 7, TRUE, erode = integer())
getLines(ll, asIs = TRUE, horizontal = TRUE)
```
<!--
```
pp = pixRead(f)
pp8 = pixConvertTo8(pp)
ll = findLines(pp8, 201, 7, TRUE, erode = integer())
```
-->

1. [fixed] Had a crash with some code after a while in inst/images/readPlot.R (inside the if(FALSE)..)
   + Several calls to GetImage(). So this may be fixed now?
     + See the parse/eval code at the top of the file to run.

1. [done] tests/vertText.R and erroneous single row bounding box for rotated and SetRectangle text.
    + The first segment to extract text from the rotated image
	```
ts = tesseract(p1)
#XXX This gives nonsensical values for 
SetRectangle(ts, dims = c(500, 4900, 3000, 100))
bb = GetBoxes(ts)	
	```
	 gives a single row of a data frame and the coordinates are way beyond the dimensions of the
	image.
	   + They appear to be somewhat random and suggest uninitialized values.
	   + This was the problem. The iterator had nothing in it, but for some reason we were starting
         the count at 1 and so we were filling in the values with garbage.
	+ But the next code segment where we focus on the correct region gives proper results.

1. [done] nrow, ncol, dim methods for the tesseract object itself?
    + have a dim() method

1. [done] Add method for tesseract() to be called with a Pix, 
```
p = pixRead("inst/images/sampleImage.jpg")
a = tesseract(p)
bb = GetBoxes(a)
```
   (otherwise,
	   tess = tesseract()
	   SetImage(tess, pix)
   )
1. [done] Method for plot for Pix, i.e. plot(pix). So equivalent to showPix but in R.
	Not necessarily going to a file. But may want this so that we don't have to deal with color issue. 
    Deal with colors for rasterImage().
1. [done] Make nrow and ncol generics and export??
1. [done] Add webp, jp2, etc. to the image formats supported (TRUE/FALSE)
     Do this by adding examples to the configuration that calls the readImage application we compile.
1. [done] pixGetInputFormat(), pixGetDepth()
1. [done] nrow, ncol, dim method for PIX/Pix	
1. [done] Check if a Pix is already in 8bpp
    pixGetDims(pix)[3] or pixGetDepth()
1. [done] Check plot.OCR(, cropToBoxes = TRUE)   
1. [done] Add IFF_ prefix to asEnumValue() for InputFileFormat so can do pixWrite(,, "PNG") w/o the IFF_
    But of course can use IFF_PNG w/o the quotes.
1. [fixed] Segfault for pixGetRGBPixels()
  ```
  library(Rtesseract)
  p = pixRead("inst/images/SMITHBURN_1952_p3.png")
  pixGetRGBPixels(p)
  ```
   Wrong indexing into the R matrix!

1. [Yes] Check tesseract(config = ...) and tesseract(vars = ...) are working correctly.
  Calling tesseract on the command line creates vhlinfinding.pdf in 
  ```
  tesseract SMITHBURN_1952_p3.png foo   config 
  ```
  but not 
```
  library(Rtesseract)
  a = tesseract("SMITHBURN_1952_p3.png", configs = "config", pageSegMode = "psm_auto")
  Recognize(a)
```  
  Need pageSegMode = "psm_auto".

1. [no] GetInputName is taking a long time - Seems fine.
1. [done] don't use LIB_R_EXIT - commented out from configure.ac now

1. [done] Put the correct row and column numbers on plotSubImage axes if we are going to talk about it in the paper.

1. [done] Make plotSubImage handle multiple rows.

1. [done] Method for plotSubImage() for data.frame of OCRResults.

1. [done] Cleanup getLines() to not need both hor and vert - just one, or default for both,
   +  [done] methods to deal with a Pix or an API object and 
      + coerce to a Pix handles this for both TesseractBaseAPI and character/file name.
   + [Done] do the binary/8-bit conversion - pixConvertTo8().

+ [yes] Does the ResultIterator get released?

+ [done] ProcessPages in render.cpp

+ [done - changed to upper to match API] ??Change the names of the functions to initial lower case, e.g. getInputName(), ?

+ [Done] Plot the image and the components and show the confidence level for each  box
   See tests/plot.R
   
+ [done] switch getAlternatives() method for TessBaseAPI to use ResultIterator method.
+ [done] getAlternatives(ri) may not want to just get the alternatives for the current cursor in the iterator, but all of them.

+ [resolved] Additionally, seems to be returing alternatives at the wrong level (Returns a single letter, only the first letter) 
  Does ChoiceIterator() only work for characters/symbols, not words.
  - need to check that this is operating correctly.
   This is because we never call Next(), but lapply(ri, fun, level) does. And we have to specify the
   level here.
   
+ [Done] GetAlternatives - use getAlternatives
    + Only returns one
    + Segfaults.
    + Look at the R_ocr_alternatives and see if we can reuse that code.
    + Note that ocr(alternatives = TRUE) works.

+ [done] create searchable pdf - use their renderer
  want to be able to fix the errors and then create it.
  Started in example in pdf.R and code in render.cpp.
     It generates a pdf but it cannot be opened.  
   Needed a finalizer on the R object to call the destructor to close the file.

+ [resolved - ocr removed] Test that output is the same and correct between ocr and getXXX functions.

+ [done] Make function calls consistent (getXXX to GetXXX)
+ [done] remove the ocr() function
+ [done] Add an example for lapply.Rd with an R function.
+ [done] Merge tesseractFuns.Rd
+ [done from NAMESPACE] remove the ocr() function
+ [done] readImage not being found in plot.OCR() - .Rbuildignore was causing it to be discard due to FUNS. Matching is case-insensitive.
+ [done] Document SetInputName, SetImage

+ [done] Remove GetIterator.Rd

+ [fixed] Segfaults if Recognize hasn't been called.
```
 library(Rtesseract)
 ts = tesseract(system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract"))
 a = getAlternatives(ts)
```

+ [Fixed now] Investigate  "Calling Recognize again"
 ```r
  library(Rtesseract)
  ts = tesseract(system.file("trainingSample", "eng.tables.exp0.png", package = "Rtesseract"))
  b = getBoxes(ts)
 ```

+ [done] SetInputName - if no api, warn don't treat file name as api.

+ [Doesn't do better] Use the cube - Init() with an engineMode

+ [Fixed] read_params_file
          read_params_file: Can't open NA

+ [Fixed] Why does cmd-line tesseract give a different set of words as ocr()
  What about 
    ts = tesseract(fs)
    getConfidences(ts)
    The PageSegMode was being reset in the API::Init() method and we were setting it before calling that.

+ [done] get information about the current image - dimensions, other info. See getImageInfo() & getImageDims()

+ [Done] See getConfidences() on a tessseract object.  Get the confidences separately from ocr().

+ [Done] Give a blank image (i.e. a file that contains nothing) and ocr() seg faults
   created via PDFBox w/o the jbig2-imageio in the classpath
   To create one, in DSIProjects/MarkMundy, 
      java -jar ~/Downloads/pdfbox-app-2.0.2.jar PDFToImage -outputPrefix test -imageType png 1982-128-44.pdf 

+ [Done] Check if we have support for a particular image based on its type.
  Check the supported leptonica image formats.

+ [Done] cropToBoxes = TRUE in plot.OCR - get it to work.

+ [Done] When Recognize() not called, don't seg fault in lapply().

+ [Done] SetVariable and GetVariable.
     tests/vars.R
     different types.

+ [Basic] configuration

+ [Done] capabilities  - at configure time.
  e.g. image formats leptonica understands.
   leptonicaImageFormats()

+ [Done] PrintVariables scan() problem.
    Error during wrapup: line 376 did not have 3 elements
    Yet
       tt = readLines(f)
       els = strsplit(tt, "\t")
       sapply(els, length)
+ [fixed] If the file doesn't exist, get a weird  error message.

+ [Done] Make getCharWidth/Height ignore text with no content & just one space.

1. [IGNORE/not an issue] Make GetImageDims a method for GetDims() so can use the latter on a TessBaseAPI object.
  Is there a GetDims? no - just pixGetDims and GetImageDims.


