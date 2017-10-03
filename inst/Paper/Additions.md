
For the SMITHBURN p3 image with the hightlighted text, we can remove the highlight
by switching to grey scale
  
  img = pixConvertTo8(pixRead(filename))
  tesseract(img)
  
(otherwise
  tess = tesseract()
  SetImage(tess, img)
)


If we care about skew, we'll have the user call a deskew() function
defined something like

deskew = 
function(filename, pix = pixRead(filename))
{
   p1 = pixConvertTo8(p1)

   bin = pixThresholdToBinary(p1, 150)
   angle = pixFindSkew(bin)
   pixRotateAMGray(p1, angle[1]*pi/180, 255)
}

 img = deskew(img)
 tess = tesseract(img)
 plot(tess, image = img)
 
 If we have plot() extract the image from the tesseract, it may have the deskewed
