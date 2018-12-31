library(Rtesseract)

# Check the file/image format for the files in the inst/images/ directory.
dir = system.file("images",  package = "Rtesseract")
ff = list.files(dir, full = TRUE, pattern = "png|jpeg|jpg|tiff|tif")
i = lapply(ff, readImageInfo)
names(i) = ff
fmt = sapply(i, `[[`, 1)
w = match(fmt, Rtesseract:::PixFormatValues)
fmts = structure(names(Rtesseract:::PixFormatValues)[w], names = ff)



