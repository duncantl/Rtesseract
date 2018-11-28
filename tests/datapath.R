library(Rtesseract)

if(FALSE) {
d = c("~/Projects/OCR", "../", "..")
sapply(d, function(x)
            if(file.exists(paste(x, "tessdata", sep = .Platform$file.sep))) {
                a = tesseract(datapath = x)
                GetDatapath(a)
            })
}


