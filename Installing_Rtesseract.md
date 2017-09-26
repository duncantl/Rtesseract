# How to install Rtesseract 

Rtesseract requires Tesseract to be installed, either 3.0X or 4.0X
versions. For general notes on installing Tesseract, please
see
[Compiling Tesseract](https://github.com/tesseract-ocr/tesseract/wiki/Compiling) for
information from the Tesseract devs
and
[Installing Tesseract](https://github.com/duncantl/Rtesseract/blob/master/InstallingTesseract.md) for
our notes.

# Tested installs:

These are platforms where Rtesseract has been confirmed to install on,
along with any notes or special instructions.

## General notes:

  + Requires the environment variable PKG\_CONFIG\_PATH set to include the appropriate location so the
    installer knows where to find tesseract and leptonica, e.g.,
    /usr/local/lib/pkgconfig.  This is a colon-separated collection of paths identifying directories
	that contain the .pc files specifying the information for an installed package.
	
  + Compilation should use the C++11 standard. This means setting the --std=C++11 flag in CXXFLAGS.
	Otherwise, the compiler will issue warnings. 

## Linux

### CentOS 7

Tesseract version | R version | Compiler | Notes
------------------|-----------|----------|-------
3.05.0X | 3.4.1 | g++ 6.2 | OK 
4.00.00dev | 3.4.1 | g++ 6.2 | OK 
4.00.00dev | 3.4.0 | g++ 4.8.5 | OK 


### Arch Linux

kernel 4.12.8.2

Tesseract version | R version | Compiler | Notes
------------------|-----------|----------|-------
3.05.0X | 3.4.1 | g++ 7.1. | OK 
4.00.00dev | 3.4.1 | g++ 7.1 | OK 
3.05.0X | 3.4.1 | clang 4.0.1 | OK 
4.00.00dev | 3.4.1 | clang 4.0.1 | OK 

### Debian

7.0 Jessie (rocker/rstudio Docker image)

Tesseract version | R version | Compiler | Notes
------------------|-----------|----------|-------
3.05.0X | 3.4.1 | g++ 6.3.0 | OK 
4.00.00dev | 3.4.1 | g++ 6.3.0 | OK 
	
## OS X

Tesseract version | R version | Compiler | Notes
------------------|-----------|----------|-------
3.05.0X | 3.4.? | Apple clang | Cannot compile tesseract 
4.00.00dev | 3.4.? | Apple clang | Cannot compile tesseract
 
## MS Windows

Tesseract version | R version | Compiler | Notes
------------------|-----------|----------|-------
3.05.0X | 3.4.1 | g++ 6.3.0 | Have not attempted yet
4.00.00dev | 3.4.1 | g++ 6.3.0 | Have not attempted yet



