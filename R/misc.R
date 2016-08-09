getSmudges =
    #
    # Identify what are probably specs/smudges from the scanning process that are not characters.
    # These are small boxes. We also want them to be far way from other elements.
    #
function(bbox, threshold = 5, charWidth = getCharWidth(bbox), charHeight = getCharHeight(bbox), anywhere = FALSE)
{
  w = bbox[,3] - bbox[,1]
  h = bbox[,4] - bbox[,2]
  i = which( w < .25*charWidth & h < .25*charHeight )
  if(!anywhere)
      return(i)
  
  D = as.matrix(dist(bbox))
  m = apply(D[i, , drop = FALSE], 1, function(x) sort(x)[2])
  i [  m > 3*charWidth ]
}


getCharWidth =
    #
    # get an estimate of the typical character width
    #
function(bbox, fun = median, onlyAlphaNumeric = TRUE)
{
   if(onlyAlphaNumeric)
      bbox = bbox[ grepl( "[A-Za-z0-9]", getText(bbox)), ]
   
   fun(  (bbox[,3] - bbox[,1])/nchar(getText(bbox)) )
}


getCharHeight =
    #
    # get an estimate of the typical character height
    #
function(bbox, fun = median, onlyAlphaNumeric = TRUE)
{
   if(onlyAlphaNumeric)
      bbox = bbox[ grepl( "[A-Za-z0-9]", getText(bbox)), ]
   
   fun(  (bbox[,4] - bbox[,2])  )
}    

getText =
    #
    # get the text from a bbox which can either be a matrix with rownames as text, or a data frame with a "text" column.
    #
function(x)
{
   if(is.data.frame(x))
      x$text
   else
      rownames(x)
}



bboxToDF =
    #
    # Convert a matrix describing the boundary boxes into a data frame.
    #
    #
function(bb)
{
    if(is.data.frame(bb))
        return(bb)
    
    txt = rownames(bb)
    bb = as.data.frame(bb)
    rownames(bb) = NULL
    bb$text = txt
    bb
}


orderBBox =
    #
    # Given a bbox, order the rows based on the colName given as a name or index.
    # We can use decreasing to order them in increasing or decreasing order.
    # The order helps us compute differences between adjacent lines or columns.
    #
function(bbox, colName = "bottom",  decreasing = TRUE)
{
   o = order(bbox[, colName], decreasing = decreasing)
   bbox[o, ]
}
