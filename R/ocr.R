ocr = 
function(img, level = PageIteratorLevel["word"], 
         alternatives = FALSE, boundingBox = FALSE,
         opts = sapply(list(...), as, "character"), ...)
{
   if(alternatives && boundingBox)
     stop("Currently, we don't calculate both the bounding boxes and the alternatives")

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

   if(boundingBox)
     return(.Call("R_ocr_boundingBoxes", img, opts, as.integer(level), c("confidence", "x1", "y1", "x2", "y2")))
   
   sym = if(as.logical(alternatives)) 
            "R_ocr_alternatives" 
         else
            "R_ocr"
  .Call(sym, img, opts, as.integer(level))
}

#ocr("IMG_1234.jpg", opts = c("tessedit_char_whitelist" = "0123456789."))
