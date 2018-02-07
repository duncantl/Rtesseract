
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
R_pixDilateGray(SEXP r_pix, SEXP r_horiz, SEXP r_vert)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixDilateGray(pix, INTEGER(r_horiz)[0], INTEGER(r_vert)[0]);
    return(createRef(ans, "PIX", R_pixDestroy));    
}

extern "C"
SEXP
R_pixOpenGray(SEXP r_pix, SEXP r_horiz, SEXP r_vert)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixOpenGray(pix, INTEGER(r_horiz)[0], INTEGER(r_vert)[0]);
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
R_pixRotate(SEXP r_pix, SEXP r_angle, SEXP r_type, SEXP r_incolor, SEXP r_width, SEXP r_height)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixRotate(pix, REAL(r_angle)[0], INTEGER(r_type)[0], INTEGER(r_incolor)[0], INTEGER(r_width)[0], INTEGER(r_height)[0]);
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
R_pixSetRes(SEXP r_pix, SEXP r_vals)
{
    PIX *pix = GET_REF(r_pix, PIX);
    l_int32 ans = pixSetResolution(pix, INTEGER(r_vals)[0], INTEGER(r_vals)[1]);
    return(ScalarInteger(ans));
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
            p[i + j*r] = R;
            p[i + j*r + r*c] = G;
            p[i + j*r + r*c*2] = B;

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
    if(fmt) {
        PROBLEM  "error in pixZero()"
           ERROR; 
    }
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


extern "C"
SEXP
R_pixCountRGBColors(SEXP r_pixs)
{
   PIX *pixs = GET_REF(r_pixs, PIX);
   return ( ScalarInteger( pixCountRGBColors(pixs)    ));
}



extern "C"
SEXP
R_pixEqual(SEXP r_pixs1, SEXP r_pixs2, SEXP r_useAlpha, SEXP r_useCMap)
{
    PIX *pixs1 = GET_REF(r_pixs1, PIX);
    PIX *pixs2 = GET_REF(r_pixs2, PIX);
    l_int32 val = -1;
    l_int32 ans;
    if(LOGICAL(r_useAlpha)[0])
       ans = pixEqualWithAlpha(pixs1, pixs2, 1, &val);        
    else {
       if(LOGICAL(r_useAlpha)[0])
          ans = pixEqualWithCmap(pixs1, pixs2, &val);            
       else
          ans = pixEqual(pixs1, pixs2, &val);
    }
    
    if(ans) {
        PROBLEM "pixEqual() error"
            ERROR;
    }
    
    return(ScalarLogical(val));
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
R_pixGetSubsetPixels(SEXP r_pix, SEXP r_i, SEXP r_j)
{
    PIX *pix = GET_REF(r_pix, PIX);
    
    size_t r = Rf_length(r_i);
    size_t c = Rf_length(r_j);    
    
    SEXP ans = NEW_NUMERIC(r * c);
    double *p = REAL(ans);

    int *pi, *pj;
    pi = INTEGER(r_i);
    pj = INTEGER(r_j);
    
    l_uint32 val;
    int i, j;    
    for(j = 0; j < c; j++) {
        for(i = 0; i < r; i++) {
            pixGetPixel(pix, pj[j] - 1 , pi[i] - 1, &val);
            p[i + j*r] = val;
        }
    }
    
    return(ans);
}



#define PIX_PIXD_HOR_VER(name) \
extern "C" \
SEXP  \
R_##name(SEXP r_pix, SEXP r_pixd, SEXP r_horiz, SEXP r_vert) \
{ \
    PIX *pix = GET_REF(r_pix, PIX); \
    PIX *pixd = (r_pixd != R_NilValue) ? GET_REF(r_pixd, PIX) : NULL; \
 \
    PIX *ans = name(pixd, pix, INTEGER(r_horiz)[0], INTEGER(r_vert)[0]); \
\
    if(r_pixd == R_NilValue)                             \
       return(createRef(ans, "PIX", R_pixDestroy));      \
    else  \
       return(r_pixd);      \
}

PIX_PIXD_HOR_VER(pixOpenBrick)
PIX_PIXD_HOR_VER(pixCloseBrick)
PIX_PIXD_HOR_VER(pixDilateBrick)
PIX_PIXD_HOR_VER(pixErodeBrick)




extern "C"
SEXP
R_pixSet2DMatrixVals(SEXP r_pix, SEXP r_midx, SEXP r_vals)
{
    int *pv = INTEGER(r_vals), *pidx = INTEGER(r_midx);
    int i, j, r, c, depth, row, x, y;
    PIX *pix = GET_REF(r_pix, PIX);
    pixGetDimensions(pix, &c, &r, &depth);

    int nr = Rf_nrows(r_midx);
    for(row = 0; row < nr;  row++) {
        // column 1 of r_midx is the rows, col 2 is the columns
        y = pidx[row] - 1;
        x = pidx[row + nr] -1;
        l_uint32 tmp;
        //XXX
        pixGetPixel(pix, x, y, &tmp);
        Rprintf("%d, %d (%d) -> %d\n", x, y, tmp, pv[row]);
        pixSetPixel(pix, x, y, pv[row]);
    }
    
    return(R_NilValue);
}


extern "C"
SEXP
R_pixSetAllPixels(SEXP r_pix, SEXP r_dims, SEXP r_vals)
{
    PIX *pix = GET_REF(r_pix, PIX);
    
    size_t r = INTEGER(r_dims)[0];
    size_t c = INTEGER(r_dims)[1];    
    
    double *vals = REAL(r_vals);
    int i, j;    
        for(j = 0; j < c; j++) {
    for(i = 0; i < r; i++) {
            pixSetPixel(pix, j, i, *vals);
            vals++;
        }
    }
    
    return(r_pix);
}



extern "C"
SEXP
R_pixSetMatrixVals(SEXP r_pix, SEXP r_i, SEXP r_j, SEXP r_vals)
{
    int *pv = INTEGER(r_vals), *p_i = INTEGER(r_i), *p_j = INTEGER(r_j);
    int i, j, depth, x, y;
    PIX *pix = GET_REF(r_pix, PIX);
//    pixGetDimensions(pix, &c, &r, &depth);

    int r = Rf_length(r_i);
    int c = Rf_length(r_j);
    int ctr = 0;
    int nvals = Rf_length(r_vals);
    for(i = 0; i < r; i++)
        for(j = 0; j < c ; j++, ctr++) {
            x = p_j[j] - 1;
            y = p_i[i] - 1;
//            Rprintf("%d, %d  (%d)  %d\n", x, y,  ctr % nvals,  pv[ ctr % nvals ]);
            pixSetPixel(pix, x, y, pv[ ctr % nvals ]); //XXX
    }
    
    return(r_pix);
}




extern "C"
SEXP
R_pixFlipLR(SEXP r_pix, SEXP r_target)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixFlipLR(r_target != R_NilValue ? GET_REF(r_target, PIX) : NULL, pix);
    if(r_target == R_NilValue)
       return(createRef(ans, "PIX", R_pixDestroy));    
    else
        return(r_target);
}


extern "C"
SEXP
R_pixFlipTB(SEXP r_pix, SEXP r_target)
{
    PIX *pix = GET_REF(r_pix, PIX);
    PIX *ans = pixFlipTB(r_target != R_NilValue ? GET_REF(r_target, PIX) : NULL, pix);
    if(r_target == R_NilValue)
       return(createRef(ans, "PIX", R_pixDestroy));    
    else
        return(r_target);
}


extern "C"
SEXP
R_pixCreate(SEXP r_dims)
{
    int *dims = INTEGER(r_dims);
    PIX *ans = pixCreate(dims[1], dims[0], dims[2]);
    return(createRef(ans, "Pix", R_pixDestroy));    
}


extern "C"
SEXP
R_pixSetDimensions(SEXP r_pix, SEXP r_dims)
{
    PIX *pix = GET_REF(r_pix, PIX);
    int * dims = INTEGER(r_dims);
    return(ScalarInteger(pixSetDimensions(pix, dims[0], dims[1], dims[2])));
}
