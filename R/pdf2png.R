

# We may want to have the pdf2png function 
# + create a new temporary directory
# + copy the original file to the new temp directory, 
# + perform the conversion there so that no other process will modify the directory
# + move the generated files back to the original directory
# + remove the temporary directory
# This will guarantee that the files we find at the end will be associated with 
# this conversion and not some other application writing into that directory at
# the same time.


pdf2png =
function(file, ...,
         convertCmd = system.file("bin/pdf2png", package = "Rtesseract"),
         .args = list(...), .dir = tempdir(check = TRUE))
{
    file = normalizePath(file)
    
    # XXX check if files with the suffix already exist and return those if they do.
    # Put in separate function
    ex = getConvertedFilenames(file)
    if(length(ex))
       return(structure(ex, class = "Filenames"))

    
    # XXX handle ... - make specific to pdf2png (density and base) or generic as ...
    # if .args has names, we should use those - but how
    #  -name value or --name=value
    
    cur = getwd()
    on.exit({setwd(cur); unlink(list.files(.dir, full.names = TRUE));unlink(.dir)})

    setwd(.dir)
    if(!file.copy(file, file.path(.dir, basename(file))))
        stop("Problem copying original file")
    
    before = list.files(".", full = TRUE)
    system(sprintf("%s %s %s", convertCmd, paste(.args, collapse = " "), basename(file)))
    after = list.files(".", full = TRUE)
    files = sort(setdiff(after, before))
    file.copy(files, cur)
    
    structure(file.path(cur, files), class = "Filenames")
}

getConvertedFilenames =
function(file, dir = dirname(file),
         base = rmExt(basename(file)),
         suffix = "_p[0-9]+\\.png",
         pattern = sprintf("%s%s", base, suffix))
{
  list.files(dir, pattern = pattern, full.names = TRUE)
}

getExt = getExtension =
function(filename)
{
    gsub(".*\\.", "", filename)
}

rmExt =
function(filename, ext)
{
   gsub("\\.$", "", gsub(ext, "", filename, fixed = TRUE))
}
