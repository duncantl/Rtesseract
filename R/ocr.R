PageIteratorLevel = c(block = 0L, para = 1L, textline = 2L, word = 3L, symbol = 4L)

ocr = 
function(img, level = PageIteratorLevel["word"], alternatives = FALSE,
         opts = sapply(list(...), as, "character"), ...)
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

   opts = as(opts, "character")

   if(alternatives)
      opts["save_blob_choices"] = "T"

   sym = if(as.logical(alternatives)) "R_ocr_alternatives" else "R_ocr"
   .Call(sym, img, opts, as.integer(level))
}

#ocr("IMG_1234.jpg", opts = c("tessedit_char_whitelist" = "0123456789."))