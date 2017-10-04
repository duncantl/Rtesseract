
deskew =
function(pix, binaryThreshold = 150, background = 255, angle = NA)
{
    pix = as(pix, "Pix")
    pix = pixConvertTo8(pix)

    if(is.na(angle)) {
        bin = pixThresholdToBinary(pix, binaryThreshold)
        angle = pixFindSkew(bin)
    }
    pixRotateAMGray(pix, angle[1]*pi/180, background)    
}
