ocr =
  # ocr(system.file("images", "IMG_1234.png", package = "Rtesseract"), opts = c("tessedit_char_whitelist" = "0123456789."))
  #
  # tryCatch( ocr("Rtesseract/inst/images/IMG_1234.jpg"), error = function(e) class(e) )
    
function(img, level = PageIteratorLevel["word"],
         pageSegMode = "psm_single_block",
         alternatives = FALSE, boundingBox = FALSE,
         opts = sapply(list(...), as, "character"), ...)
{
   if(alternatives && boundingBox)
     stop("Currently, we don't calculate both the bounding boxes and the alternatives")

   img = path.expand(as.character(img))
   if(!file.exists(img))
     stop("image file ", img, " does not exist")

   checkImageTypeSupported(img)

   level = as(level, "PageIteratorLevel")

#   if(is.character(level)) {
#     tmp = level
#     level = PageIteratorLevel[level]
#     if(is.na(level))
#       stop("no match for ", tmp)
#   }

   opts = as(opts, "character")

   if(alternatives)
      opts["save_blob_choices"] = "T"

   if(boundingBox) {
                                                                                  #was       "x1", "y1", "x2", "y2"
     tmp = .Call("R_ocr_boundingBoxes", img, opts, level, c("confidence", c("bottom.left.x", "bottom.left.y", "top.right.x", "top.right.y")))
     return(do.call(rbind, tmp))
   }
   
   sym = if(as.logical(alternatives)) 
            "R_ocr_alternatives" 
         else
            "R_ocr"
  .Call(sym, img, opts, as.integer(level))
}




checkImageTypeSupported =
function(file)
{
  ext = tolower(getExtension(file))

  if(ext == "jpeg")
      ext = "jpg"

  sup = leptonicaImageFormats()
  ok = FALSE
  if(ext %in% names(sup))
    ok = sup[ext]
  
  if(!ok) 
    stop( mkError(paste("we don't support this image format. The installed leptonica supports ", paste(names(sup)[sup], collapse = ", ")),
                  "UnsupportedImageFormat", filename = file))

  ok
}

getExtension =
    #  getExtension(list.files(system.file("images", package = "Rtesseract")))
    #  getExtension(getwd())
function(file, default = "")
{
   if(grepl("\\.([A-Za-z]+)$", file))
     gsub(".*\\.([A-Za-z]+)$", "\\1", file)
   else
     default
}



mkError =
    #
    # For creating structured errors with classes that can be used in tryCatch()
    #
function(message, class = character(), call = NULL, ...)
{
  e = simpleError(message, call)
  
#  e = append(e, list(...))
  args = list(...)
  e[names(args)] = args
  
  class(e) = c(class, class(e))
  e
}
