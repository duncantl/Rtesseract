# Rtesseract package

This is an R interface to the tesseract OCR (Optical Character Recognition) system.

tesseract is available at https://code.google.com/p/tesseract-ocr/.

More recent versions are available on github
  https://github.com/tesseract-ocr/tesseract

Installing tesseract involves first installing leptonica
http://www.leptonica.com/.

This is currently a basic interface to the essential functionality, with some
added R functionality to visualize the results.

1. Of course, the package provides functionality to get the recognized text.
However, it also allows us to do this at various different levels, e.g.
word, character, line
3. We can create a searchable and selectable PDF version of the image(s).
3. We can output the results of the OCR to a tab-separated-value file, an HTML (hocr) file, a BoxText, a UNLV, or a OSD file.
2. We can also use different page segmentation modes so that we can detect/recognize
lines on the image which is useful for processing tables where the lines separate
rows or columns
3. We can get the confidence for each recognized text element to understand whether it is 
  a good match or not.
3. We can get the location and dimensions of each of the text elements. Again, this is 
 necessary for processing tables and other structured content.
3. We can display the matched text, the associated confidences to see spatial patterns.
 Also, we can overlay this on the original image to see patterns.
3. We can restrict the recognition to a sub-rectangle of the image.
3. The package provides lower-level access to the C++ API, allowing for more fine-grained and efficient
 use and flexible programmatic access.
3. We can set and query many variables controlling tesseract's behavior.
3. We can query details about the image.
3. We can manipulate an image as an array of pixels
3. We interface to numerous leptonica routines to process images, e.g., convert to gray scale or
   binary images, rotate and transpose images
3. Functionality to read images and their metadata to determine their formats
3. Read multi-page TIFF documents.
3. We can query the metadata about the version of tesseract, the supported image formats, etc.
3. 


We can machine generate the interface to the other methods and classes in the tesseract API/library.

## Converting Documents to Images

Often we will start with a scanned document already as a single image.
Assuming leptonica was installed with support for that image format, we can read the image directly.


### Multipage PDF
In many of our use cases, we start with a PDF document that consists of multiple scanned pages.
Each page is a scanned image.  Tesseract/leptonica does not read this directly.
Instead, we need to convert the PDF document into a different format.
We ue ImageMagick, and specifically its very general and powerful convert command, to convert
between image formats. 

#### Separate Image File for each Page
If we want to create a separate image for each page in the original PDF, 
we can use the script pdf2png in this package (inst/scripts/pdf2png). This hides some of the
details of convert. (This can convert to JPEG and other formats, in spite of what the name
suggests.)
```
pdf2png SMITHBURN_1952.pdf
```
This will generate png files with names SMITHBURN_1952_0000.png, ...
We can specify the filename format.

We can also specify the density (points per pixel), the quality/level of compression, and any other
command line arguments `convert` supports.

#### Multipage Image Format
Alternatively, we can convert the PDF document to a multi-page/image TIFF file, i.e. a single TIFF
file that contains multiple images.  We then read this into R using the `readMultipageTiff()`
function and then access each page from the resulting list.


To convert a multipage PDF document to a multipage TIFF file, use, e.g.,
```
convert SMITHBURN_1952.pdf SMITHBURN_1952.tiff
```



## History
We - Matt Espe & Duncan Temple Lang - started developing this package in April 2015.







<!--
install_name_tool  -change libtesseract.4.0.0.dylib /usr/local/lib/libtesseract.4.0.0.dylib src/Rtesseract.so 
-->
