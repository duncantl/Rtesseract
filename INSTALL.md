Tesseract 4.0 is currently not as easy to install on all systems as earlier versions.
Version 4.0 is not officially released, so these difficulties are understandable.


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

