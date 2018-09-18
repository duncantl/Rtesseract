Tesseract 4.0 is currently not as easy to install on all systems as earlier versions.
Version 4.0 is not officially released, so these difficulties are understandable.


# General

+ Missing eng.traineddata and other training files

The language files are specific to the Tesseract version. For Tesseract 4.0+, you can use either files from [tessdata_best](https://github.com/tesseract-ocr/tessdata_best), as suggested [here](https://github.com/tesseract-ocr/tesseract/issues/1205).
The tessdata_fast files will also work.

For Tesseract versions 3.04+, you need to use the files from tessdata: https://github.com/tesseract-ocr/tessdata   

These files can be put into the default search locations (e.g., /usr/local/share) or Tesseract can be told where to find them with the `tessdata` flag.

3) aspell
R CMD BUILD said I was misisng aspell, so I got from [omegahat.net](http://www.omegahat.net/Aspell/)
You might need to apply this [fix](https://stackoverflow.com/questions/25395685/aspell-wont-build-on-os-x-10-9-mavericks)


# Ubuntu
On Ubuntu, we use clang
 ./configure CXX=clang++ CC=clang
 
The option --disable-openmp doesn't disable it fully and we get an error when
compiling the code in the lstm/ directory.

So we install libopenmp-dev.


On Ubuntu with clang 3.8, we added the std:: prefix
in lstm/lstmrecognizer.cpp
  std::isnan()
in LabelsViaThreshold()
(See https://stackoverflow.com/questions/39130040/cmath-hides-isnan-in-math-h-in-c14-c11)


# OSX

## Troubleshooting

problems after install of tesseract 4.0.0-beta.4 from source

1)  !strcmp(locale, "C"):Error:Assert failed

Originates with this line in baseapi.cpp: ASSERT_HOST(!strcmp(locale, C));
The error is due to a recent change in tesseract source: https://github.com/tesseract-ocr/tesseract/commit/3292484f67af8bdda23aa5e510918d0115785291#diff-903b81bdfe923135ee1d03800c400ed8
See https://github.com/tesseract-ocr/tesseract/issues/1670

Since this is an unresolved issue, for now I just undid that change in the tesseract code (in src/api/baseapi.cpp) 

