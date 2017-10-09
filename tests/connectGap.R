library(Rtesseract)
a = structure(c(577L, 1443L, 1955L, 2242L, 2496L, 2742L, 2988L, 3241L, 
1418L, 1932L, 2218L, 2472L, 2720L, 2968L, 3226L, 3468L), .Dim = c(8L, 
                                                             2L))


connectGap = Rtesseract:::connectGap

# All the ones with small gap are at the end.
g = connectGap(a, 23)
stopifnot(nrow(g) == 5)

# small gap at beginning so the first two rows should merge
a[1,2] = 1423
connectGap(a, 23)

# small gap in middle,
a[3,2] = 2220
connectGap(a, 1)

# Adding a larger gap to the last one.
a[8,1] = 3251
connectGap(a, 23)

