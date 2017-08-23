# How to install Rtesseract 

Rtesseract requires Tesseract to be installed, either 3.0X or 4.0X
versions. 

# Tested installs:

## General notes:

  + Requires PKG\_CONFIG\_VAR set to the appropriate location so the
    installer knows where to find tesseract and leptonica, e.g.,
    /usr/local/lib/pkgconfig.
	
  + Compilation requires C++11 standards, on clang (and some versions
    of gcc <= 4.8.5?) this means setting the --std=C++11 flag
	

## Linux

### CentOS

Tesseract version | R version | Compiler | Notes
------------------|-----------|----------|-------
3.05.0X | 3.4.1 | g++ 6.2 | OK 
4.00.00dev | 3.4.1 | g++ 6.2 | OK 


### Arch Linux

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
3.05.0X | 3.4.1 | g++ 6.3.0 | Cannot compile tesseract 
4.00.00dev | 3.4.1 | g++ 6.3.0 | Cannot compile tesseract
 
## MS Windows

Tesseract version | R version | Compiler | Notes
------------------|-----------|----------|-------
3.05.0X | 3.4.1 | g++ 6.3.0 | Have not attempted
4.00.00dev | 3.4.1 | g++ 6.3.0 | Have not attempted
