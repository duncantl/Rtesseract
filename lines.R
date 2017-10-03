library(Rtesseract)
f = "inst/images/SMITHBURN_1952_p3.png"
# .Call("R_leptLines", "inst/images/SMITHBURN_1952_p3.png", "sm_p3.png")
#source("R/leptonica.R")

# Not producing exactly the same as the C code
# Look at which files are different.
#
ff = c("pixs.png", "cpixs.png",
    "bin1.png", "cbin1.png",
    "p2.png",   "cpix2.png",
    "p3.png",   "cpix3.png",
    "p4.png",   "cpix4.png",
    "p5.png",   "cpix5.png",
    "p6.png",   "cpix6.png",
    "horLines.png",  "cpix7.png",
    "page3.png" , "sm_p3.png")


p1 = pixRead("inst/images/SMITHBURN_1952_p3.png")
# ?? Do we need to go to 8 bit.
p1 = pixConvertTo8(p1)
#pixWrite(p1, "pixs.png", IFF_PNG);# Open("pixs.png")

# Need to go to binary image for detecting skew.
bin = pixThresholdToBinary(p1, 150)

# Now detect skew and rotate the image appropriately.
angle = pixFindSkew(bin)
p2 = pixRotateAMGray(p1, angle[1]*pi/180, 255)
#pixWrite(p2, "p2.png", IFF_PNG); Open("p2.png")

getLines = 
function(pix, hor, vert, asLines = FALSE, invert = TRUE)
{
   p3 = pixCloseGray(pix, hor, vert)
   p4 = pixErodeGray(p3, 3, 5)

   p5 = pixThresholdToValue(p4, 210, 255, p4)
   p6 = pixThresholdToValue(p4, 210, 0, p4)

   # We don't use this again in these computations, but we want it to get the actual lines.
   if(asLines)
      return(pixThresholdToBinary(p6, 210))
   
   if(invert)
       pixInvert(p6)
   else
       p6
}

#pixWrite(bin, "horLines.png", IFF_PNG); #Open("horLines.png")

# Turn "black" lines white.
#pixInvert(p6, p6)

p6 = getLines(p2, 51, 5) # horizontal lines
p7 = getLines(p2, 1, 51) # vertical lines
p8 = pixAddGray(p2, p6)
p8 = pixAddGray(p8, p7)

pixWrite(p8, "page3.png", IFF_PNG); #Open("page3.png")


m = matrix(ff, , 2, byrow = TRUE)
apply(m, 1, function(x) length(unique(file.info(x)$size)) == 1)
