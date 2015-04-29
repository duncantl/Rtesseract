PageIteratorLevel = c(block = 0L, para = 1L, textline = 2L, word = 3L, symbol = 4L)

ocr = 
function(img, opts = character(), level = PageIteratorLevel["word"])
{
   img = path.expand(as.character(img))
   if(!file.exists(img))
     stop("image file ", img, " does not exist")

    if(is.character(level)) {
      tmp = level
      level = PageIteratorLevel[level]
      if(is.na(level))
        stop("no match for ", tmp)
    }

   .Call("R_ocr", img, as(opts, "character"), as.integer(level))
}

#ocr("IMG_1234.jpg", opts = c("tessedit_char_whitelist" = "0123456789."))