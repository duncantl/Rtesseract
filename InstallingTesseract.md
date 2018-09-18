
From source:

automake
libtool

leptonica

# Windows

The "easiest" / recommended path is using cmake, but cmake is not playing nice with the compiler tools that ship with Rtools. MinGW is not updated and SourceForge is down so I cannot test MinGW-64.

## Using MSYS2

### Prep

MSYS2 ported the `pacman` package manager, which is familiar (to me). It is fairly simple with some slight wrinkles.

1. Install MSYS2 from [here](https://www.msys2.org/) and follow their getting started steps.

1. Install the development tools needed to build from source by running:

```
pacman -S base-devel
```

1. Install leptonica

```
pacman -S leptonica
```

1. Update the pkg-config search path

```
export PKG_CONFIG_PATH=/mingw64/lib/pkgconfig/
```

### Build package

Using the PKGBUILD file, issue the following command to build Tesseract

```
makepkg -sri
```

### Dependencies:

Dependencies should be automatically installed from the `makepkg` command. In case they are not, they can be manually installed using pacman.

In MSYS2, the dependencies include a prefix string that makes the package name difficult to guess. 
Additionally, some packages are named slightly different from their Linux versions.
To find the name of the dependency so you can install using the default pacman command, search for it using regex:

```
pacman -Ss <regex> 
```

  - By default, the packages installed with pacman for MinGW are under /mingw64/bin which is not in the path. You need to add these to the path with:
  
  ```
  export PATH=$PATH:/mingw64/bin
  ```


## Install with cmake 

I generally followed the instructions here:

()[https://github.com/UB-Mannheim/tesseract/blob/master/INSTALL.GIT.md]
 
 With one modification - the correct command for building tesseract is:
 
 ```
 cmake .. -DLeptonica_DIR=/path/to/lept/build/bin
 ```
 
 
