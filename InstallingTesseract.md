
From source:

automake
libtool

leptonica

# Windows

The "easiest" / recommended path is using cmake, but cmake is not playing nice with the compiler tools that ship with Rtools. MinGW is not updated and SourceForge is down so I cannot test MinGW-64.

## Using MSYS2

MSYS2 ported the pacman package manager, which is familiar (to me). It is fairly simple wiht some slight wrinkels.

### Dependencies:

  - In MSYS2, the dependencies are a huge pain because all the names are slightly different. To find the name of the dependency so you can install using the default pacman command, search for it using regex:

```
pacman -Ss <regex> 
```

  - By default, the packages installed with pacman for MinGW are under /mingw64/bin which is not in the path. You need to add these to the path with:
  
  ```
  export PATH=$PATH:/mingw64/bin
  ```

### Install Steps

I generally followed the instructions here:

()[https://github.com/UB-Mannheim/tesseract/blob/master/INSTALL.GIT.md]
 
 With one modification - the correct command for building tesseract is:
 
 ```
 cmake .. -DLeptonica_DIR=/path/to/lept/build/bin
 ```
 
 
