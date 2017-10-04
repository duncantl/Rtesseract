
// Done
// pixThresholdToBinary
// pixRotateAMGray
// pixErodeGray
// pixCloseGray
// pixFindSkew
// pixAddGray
// pixConvertTo8
// pixThresholdToValue
// pixInvert

// Already done: pixRead, pixWrite

#include <allheaders.h>
// #include <Rdefines.h>

#include "Rtesseract.h"



// http://www.leptonica.com/line-removal.html
extern "C"
SEXP
R_leptLines(SEXP r_img, SEXP r_outfile)
{
    PIX *pixs = pixRead(CHAR(STRING_ELT(r_img, 0)));
    pixs = pixConvertTo8(pixs, 0); // 0 - no color map
//pixWrite("cpixs.png", pixs, IFF_PNG);            
    PIX *pix1, *pix2, *pix3, *pix4, *pix5, *pix6, *pix7, *pix8;

    pix1 = pixThresholdToBinary(pixs, 150);
//pixWrite("cbin1.png", pix1, IFF_PNG);            
    l_float32 angle, conf, deg2rad = 3.141592653589793/180.;
    pixFindSkew(pix1, &angle, &conf);
    
//    Rprintf("angle = %lf  (pixs=%p  pix1=%p) L_HORIZ=%d, L_VERT=%d\n", (double) angle, pixs, pix1, L_HORIZ, L_VERT);
       // 0 color to add for pixels that are brought in to picture by rotation, . 0 for black, 255 for WHITE
     pix2 = pixRotateAMGray(pixs, deg2rad * angle, 0);
//  pixWrite("cpix2.png", pix2, IFF_PNG);                
     pix3 = pixCloseGray(pix2, 51, 1L /*L_HORIZ*/);
//  pixWrite("cpix3.png", pix3, IFF_PNG);            
     pix4 = pixErodeGray(pix3, 5, 2 /*L_VERT*/);
//  pixWrite("cpix4.png", pix4, IFF_PNG);        
/*
    pix4 = pixCloseGray(pix4, 1, 51);
    pix4 = pixErodeGray(pix4, 1, 5);
*/

    pix5 = pixThresholdToValue(pix4, pix4, 210, 255);
//  pixWrite("cpix5.png", pix5, IFF_PNG);    
    pix6 = pixThresholdToValue(pix4, pix4, 200, 0);
//  pixWrite("cpix6.png", pix6, IFF_PNG);
    
    pix7 = pixThresholdToBinary(pix6, 210);
//  pixWrite("cpix7.png", pix7, IFF_PNG);
    
    pixInvert(pix6, pix6);
//    pixWrite("cpixInvert.png", pix6, IFF_PNG);    
    pix8 = pixAddGray(NULL, pix2, pix6);

    pixWrite(CHAR(STRING_ELT(r_outfile, 0)), pix8, IFF_PNG); // IFF_LPDF
    return(R_NilValue);
}




extern "C"
SEXP
R_pixThresholdToValue(SEXP r_pix, SEXP r_target, SEXP r_threshval, SEXP r_setval)
{
    PIX *ans;
    PIX *pix = GET_REF(r_pix, PIX);    
    ans = pixThresholdToValue(r_target != R_NilValue ? GET_REF(r_target, PIX) : NULL, pix,
                              INTEGER(r_threshval)[0], INTEGER(r_setval)[0]);
    if(r_target == R_NilValue)
       return(createRef(ans, "PIX", R_pixDestroy));    
    else
       return(r_target);    
}

extern "C"
SEXP
R_pixInvert(SEXP r_pix, SEXP r_target)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixInvert(r_target != R_NilValue ? GET_REF(r_target, PIX) : NULL, pix);
    if(r_target == R_NilValue)
       return(createRef(ans, "PIX", R_pixDestroy));    
    else
        return(r_target);
}

extern "C"
SEXP
R_pixConvertTo8(SEXP r_pix, SEXP r_colormap)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixConvertTo8(pix, LOGICAL(r_colormap)[0]);
    return(createRef(ans, "PIX", R_pixDestroy));    
}


extern "C"
SEXP
R_pixAddGray(SEXP r_pixs1, SEXP r_pixs2, SEXP r_pixd)
{
    PIX *pixs1 = GET_REF(r_pixs1, PIX);
    PIX *pixs2 = GET_REF(r_pixs2, PIX);
    PIX *pixd = (r_pixd != R_NilValue) ? GET_REF(r_pixd, PIX) : NULL;
    PIX *ans = pixAddGray(pixd, pixs1, pixs2);
    if(r_pixd == R_NilValue)
       return(createRef(ans, "PIX", R_pixDestroy));    
    else
       return(r_pixd);
}



extern "C"
SEXP
R_pixFindSkew(SEXP r_pix)
{
    PIX *pix = GET_REF(r_pix, PIX);
    l_float32 angle, conf;
    pixFindSkew(pix, &angle, &conf);
    SEXP r_ans = NEW_NUMERIC(2);
    REAL(r_ans)[0] = angle;
    REAL(r_ans)[1] = conf;
    return(r_ans);
}


extern "C"
SEXP
R_pixCloseGray(SEXP r_pix, SEXP r_horiz, SEXP r_vert)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixCloseGray(pix, INTEGER(r_horiz)[0], INTEGER(r_vert)[0]);
    return(createRef(ans, "PIX", R_pixDestroy));    
}


extern "C"
SEXP
R_pixErodeGray(SEXP r_pix, SEXP r_horiz, SEXP r_vert)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixErodeGray(pix, INTEGER(r_horiz)[0], INTEGER(r_vert)[0]);
    return(createRef(ans, "PIX", R_pixDestroy));    
}


extern "C"
SEXP
R_pixRotateAMGray(SEXP r_pix, SEXP r_angle, SEXP r_grayval)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixRotateAMGray(pix, REAL(r_angle)[0], INTEGER(r_grayval)[0]);
    return(createRef(ans, "PIX", R_pixDestroy));    
}


extern "C"
SEXP
R_pixThresholdToBinary(SEXP r_pix, SEXP r_threshval)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixThresholdToBinary(pix, INTEGER(r_threshval)[0]);
    return(createRef(ans, "PIX", R_pixDestroy));    
}



extern "C"
SEXP
R_pixGetDims(SEXP r_pix)
{
    PIX *pix = GET_REF(r_pix, PIX);
    SEXP ans = NEW_INTEGER(3);
    INTEGER(ans)[0] = pixGetHeight(pix);
    INTEGER(ans)[1] = pixGetWidth(pix);
    INTEGER(ans)[2] = pixGetDepth(pix);
    return(ans);
}

extern "C"
SEXP
R_pixGetRes(SEXP r_pix)
{
    PIX *pix = GET_REF(r_pix, PIX);
    SEXP ans = NEW_INTEGER(2);
    INTEGER(ans)[1] = pixGetXRes(pix);
    INTEGER(ans)[0] = pixGetYRes(pix);
    return(ans);
}

extern "C"
SEXP
R_pixGetPixels(SEXP r_pix)
{
    PIX *pix = GET_REF(r_pix, PIX);
    int r, c;
    pixGetDimensions(pix, &c, &r, NULL);
    SEXP ans = NEW_NUMERIC(r * c);
    double *p = REAL(ans);

    l_uint32 val;
    int i, j;    
    for(j = 0; j < c; j++) {
        for(i = 0; i < r; i++) {
            pixGetPixel(pix, j, i, &val);
            p[i + j*r] = val;
        }
    }
    
    return(ans);
}



extern "C"
SEXP
R_pixSetPixels(SEXP r_pix, SEXP r_vals)
{
    PIX *pix = GET_REF(r_pix, PIX);
    int r, c;
    pixGetDimensions(pix, &c, &r, NULL);
    double *p = REAL(r_vals);

    l_uint32 val;
    int i, j;
    for(j = 0; j < c; j++) {
        for(i = 0; i < r; i++) {
            pixSetPixel(pix, j, i, p[i + j*r]);
        }
    }
    
    return(R_NilValue);
}


extern "C"
SEXP
R_pixSetRGBPixels(SEXP r_pix, SEXP r_vals)
{
    PIX *pix = GET_REF(r_pix, PIX);
    int r, c;
    pixGetDimensions(pix, &c, &r, NULL);
    int *p = INTEGER(r_vals);

    l_uint32 val;
    int i, j;
    for(j = 0; j < c; j++) {
        for(i = 0; i < r; i++) {
            pixSetRGBPixel(pix, j, i, p[i + j*r], p[i + j*r + r*c], p[i + j*r + 2*r*c]);
        }
    }
    
    return(R_NilValue);
}


extern "C"
SEXP
R_pixGetRGBPixels(SEXP r_pix)
{
    PIX *pix = GET_REF(r_pix, PIX);
    int r, c;
    pixGetDimensions(pix, &c, &r, NULL);
    SEXP ans = NEW_NUMERIC(r * c * 3);
    double *p = REAL(ans);

    l_int32 R, G, B;
    int i, j;    
    for(j = 0; j < c; j++) {
        for(i = 0; i < r; i++) {
            pixGetRGBPixel(pix, j, i, &R, &G, &B);
            p[j + i*r] = R;
            p[j + i*r + r*c] = G;
            p[j + i*r + r*c*2] = B;
        }
    }
    
    return(ans);
}

extern "C"
SEXP
R_pixGetInputFormat(SEXP r_pix)
{
    PIX *pix = GET_REF(r_pix, PIX);
    l_int32 fmt = pixGetInputFormat(pix);
    return(ScalarInteger(fmt));
}

extern "C"
SEXP
R_pixZero(SEXP r_pix)
{
    PIX *pix = GET_REF(r_pix, PIX);
    l_int32 empty = 0;
    l_int32 fmt = pixZero(pix, &empty);
    return(ScalarLogical(empty));
}

extern "C"
SEXP
R_pixClone(SEXP r_pix)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixClone(pix);
    if(ans)
       return createRef(ans, "PIX", R_pixDestroy);
    else
       return(R_NilValue);
}

#define PIX_FUN2(name) \
extern "C" \
SEXP                                             \
R_##name(SEXP r_pixs1, SEXP r_pixs2, SEXP r_pixd) \
{ \
    PIX *pixs1 = GET_REF(r_pixs1, PIX); \
    PIX *pixs2 = GET_REF(r_pixs2, PIX); \
     \
    PIX *pixd = (r_pixd != R_NilValue) ? GET_REF(r_pixd, PIX) : NULL; \
    PIX *ans = name(pixd, pixs1, pixs1); \
     \
    if(r_pixd == R_NilValue) \
       return(createRef(ans, "PIX", R_pixDestroy));     \
    else \
        return(r_pixd); \
}

PIX_FUN2(pixSubtract)
PIX_FUN2(pixAnd)
PIX_FUN2(pixOr)
PIX_FUN2(pixXor)


extern "C"
SEXP
R_pixCountRGBColors(SEXP r_pixs)
{
   PIX *pixs = GET_REF(r_pixs, PIX);
   return ( ScalarInteger( pixCountRGBColors(pixs)    ));
}


#if 0
SEXP
R_pixSubstract(SEXP r_pixs1, SEXP r_pixs2, SEXP r_pixd)
{
    PIX *pixs1 = GET_REF(r_pixs1, PIX);
    PIX *pixs2 = GET_REF(r_pixs2, PIX);
    
    PIX *pixd = (r_pixd != R_NilValue) ? GET_REF(r_pixd, PIX) : NULL;
    PIX *ans = pixSubtract(pixd, pixs1, pixs1);
    
    if(r_pixd == R_NilValue)
       return(createRef(ans, "PIX", R_pixDestroy));    
    else
        return(r_pixd);
}


SEXP
R_pixOr(SEXP r_pixs1, SEXP r_pixs2, SEXP r_pixd)
{
    PIX *pixs1 = GET_REF(r_pixs1, PIX);
    PIX *pixs2 = GET_REF(r_pixs2, PIX);
    
    PIX *pixd = (r_pixd != R_NilValue) ? GET_REF(r_pixd, PIX) : NULL;
    PIX *ans = pixOr(pixd, pixs1, pixs1);
    
    if(r_pixd == R_NilValue)
       return(createRef(ans, "PIX", R_pixDestroy));    
    else
        return(r_pixd);
}


SEXP
R_pixXor(SEXP r_pixs1, SEXP r_pixs2, SEXP r_pixd)
{
    PIX *pixs1 = GET_REF(r_pixs1, PIX);
    PIX *pixs2 = GET_REF(r_pixs2, PIX);
    
    PIX *pixd = (r_pixd != R_NilValue) ? GET_REF(r_pixd, PIX) : NULL;
    PIX *ans = pixXor(pixd, pixs1, pixs1);
    
    if(r_pixd == R_NilValue)
       return(createRef(ans, "PIX", R_pixDestroy));    
    else
        return(r_pixd);
}
#endif
