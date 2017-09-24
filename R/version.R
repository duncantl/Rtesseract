tesseractVersion =
function(patch = FALSE, runTime = TRUE)
{
    ans = if(runTime)
             .Call("R_tesseract_Version")
          else
             configInfo$tesseractVersion

    if(!patch)
        ans = paste(strsplit(ans, "\\.")[[1]][1:2], collapse = ".")
    ans
}


leptonicaVersion =
function()
{
    .Call("R_getLeptonicaVersion")
}

getImageLibs =
function(asMatrix = FALSE)
{
    x = .Call("R_getImagelibVersions")
    x = trim(strsplit(x, ":")[[1]])
    nms = gsub("^([a-zA-Z]+) .*", "\\1", x)
    nums = gsub("^([a-zA-Z]+) ", "", x)
    names(nums) = nms
    if(asMatrix) {
        matrix(as.integer(unlist( strsplit(nums, "\\."))), , 3, byrow = TRUE, dimnames = list(nms, c("major", "minor", "patch")))
    } else 
       nums
}


trim =
function (x) 
   gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)    
