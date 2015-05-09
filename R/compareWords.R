compareWord =
function(ocr, truth)
{
  if(ocr == truth)
    return(character())

  e = strsplit(c(ocr, truth), "")
  if(length(e[[1]]) != length(e[[2]])) {
      #
      warning("different lengths")
  }
  tmp = mapply(function(p, t) {
            if(p != t)
               structure(p, names = t)
            else
               character()
         }, e[[1]], e[[2]])

  collapse(tmp)
}

collapse =
function(tmp)
{
  w = sapply(tmp, length) != 0
  structure(unlist(tmp[w]), names = unlist(lapply(tmp[w], names)))
}



compareWordInfo =
function(ocr, truth)
{
  if(ocr == truth)
    return(data.frame())

  e = strsplit(c(ocr, truth), "")
  if(length(e[[1]]) != length(e[[2]])) 
      warning("different lengths")

  tmp = mapply(function(p, t, pos) {
            if(p != t)
               data.frame(ocr = p, true = t, position = pos, stringsAsFactors = FALSE)
            else
               character()
         }, e[[1]], e[[2]], seq(along = e[[1]]), SIMPLIFY = FALSE)

   do.call(rbind, tmp)
}

compareWords =
function(ocr, truth)
{
  info = mapply(compareWordInfo, ocr, truth, SIMPLIFY = FALSE)
  nr = sapply(info, nrow)
  i = nr != 0

  tmp = do.call(rbind, info[i])
  tmp$wordIndex = rep(which(i), nr[i])
  tmp$trueWord = rep(truth[i], nr[i])
  tmp$ocrWord = rep(ocr[i], nr[i])

# Get the index for each character across all of the characters so we can get the
# symbol bounding box.
# We know the position in the word and we know the word. So get the position in the entire collection of characters/symbols.  
  
  bb.index = 1:sum(nchar(ocr))
  z = split(bb.index, rep(1:length(ocr), nchar(ocr)))

  zz = lapply(seq(along = z),
             function(i) {
                  w = (tmp$wordIndex == i)
                  z[[i]][ tmp$position[w] ]
              })

  tmp$bboxIndex = unlist(zz)

  rownames(tmp) = NULL
  
  tmp
}
