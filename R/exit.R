
setAtExitFlag =
function(val)
   .C("R_setAtExitFlag", as.logical(val))
