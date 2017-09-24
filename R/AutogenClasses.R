# Copy from RAutoGenRunTime/R/classes.R
# Renamed because classes.R exists here already.
setClass("RNativeReference",
          representation(ref = "externalptr",
                         classes = "character"))

setClass("RCReference", contains = "RNativeReference")
setClass("RC++Reference", contains = "RCReference")


 # The only difference between this class and RC++Reference
 # is that we know that the names of the methods are of the form
 #    class_method
 # and so we define the $ operator differently.

setClass("RC++ReferenceUseName",
          contains = "RC++Reference")

if(FALSE) {
   setClass("RC++StructReference", contains = "RC++Reference")
       # Virtual classes with no slots that we can use as a "label" and for computing
       # names of routines, etc. from generated types.
   setClass("CStruct", contains = "VIRTUAL")
   setClass("C++Struct", contains = "CStruct")
} else {
   setClass("RCStructReference", contains = "RC++Reference")
      # Temporary
   setClass("CStruct", contains = "VIRTUAL")
   setClass("RC++StructReference", contains = "RCStructReference") 
}


if(FALSE) {
    
setClass("RNativeRoutineReference", contains = "RNativeReference")

setAs("externalptr", "RNativeRoutineReference",
       function(from)
          new("RNativeRoutineReference", ref = from))

setAs("character", "RNativeRoutineReference",
       function(from) {
         as(getNativeSymbolInfo(from), "RNativeRoutineReference")
       })

setOldClass("NativeSymbolInfo")
setAs('NativeSymbolInfo', "RNativeRoutineReference",
       function(from) {      
         as(from$address, "RNativeRoutineReference")
       })

setOldClass(c("NativeSymbol"))
setAs('NativeSymbol', "RNativeRoutineReference",
       function(from) {      
         new("RNativeRoutineReference", ref = structure(from, class = "externalptr"))
       })


setClass("ExternalArray",
            representation(elementSize = "integer"), # should be unsigned integer!
            prototype = list(elementSize = as.integer(NA)),
            contains = "RC++Reference")

# Do we want the element type as a slot here or should we work it out from the
# actual name of the class and leave it to others to use this convention or define
# a sub-class.
#XXX Should have a generic function for finding the name of the element class.
setClass("ExternalArrayWithLength",
         # length should be called dimension(s)
          representation(length = "integer"),
            contains = "ExternalArray")

 
setClass("ExternalMultiDimensionalArray", contains = "ExternalArrayWithLength")
setClass("ExternalTwoDimensionalArray", contains = "ExternalMultiDimensionalArray")

# This can be used when we know the elements are simple primitive types,
# e.g. int, double, short, long long, unsigned int, etc.
# and so we know that the corresponding object would be a vector, not a list.
# This could help us in subsetting, e.g. when handling indices that are outside
# the extent of the array dimensions.
#
# It can also indicate whether a copy argument in [ or [[ makes any sense, i.e. no for these classes.
#
setClass("ExternalPrimitiveTypeArrayWithLength",
            contains = "ExternalArrayWithLength")

#??? ? Create one also for 2D primitive type arrays ?


   # Call the function version, not the direct .Call()
   #fnName = paste("get", gsub("^([a-z])", "\\U\\1", class(x), perl = TRUE), sep = "")
   #get(fnName)(x, as.integer(i))

setMethod("[", c("ExternalArrayWithLength", "missing"),
           function(x, i, j, ...,  copy = TRUE, drop = TRUE) {
             x[seq(along = x), copy = copy, drop = drop]
           })

setMethod("[", c("ExternalArrayWithLength", "numeric"),
           function(x, i, j, ...,  copy = TRUE, drop = TRUE) {
               if(any(i > length(x)[1]))
                 stop("subscripts out of bounds (must be between 1 and ", length(x)[1], ")")
               i = i[ i != 0]
               if(any(i < 0)) {
                 if(!all(i < 0))
                   stop("only 0's may be mixed with negative subscripts")
                 i = seq(along = x)[  i]
               }
             
             rName = paste("R_subset", gsub("^([a-z])", "\\U\\1", class(x), perl = TRUE), sep = "")
             if(is(x, "ExternalPrimitiveTypeArrayWithLength"))
               .Call(rName, x, as.integer(i), x@length)
             else
               .Call(rName, x, as.integer(i), as.integer(copy), x@length)   # integer as (will) allow for a level of depth. XXX
           })


setMethod("[[", c("ExternalArrayWithLength", "numeric"),
           function(x, i, j, ...,  copy = TRUE, exact = TRUE) {
             if(length(i) > 1)
               stop("only single value for subscript")
             
             if(i < 0 | i > length(x)[1])
               stop("subscript out of bounds (must be between 1 and ", length(x)[1], ")")
             
             rName = paste("R_subset", gsub("^([a-z])", "\\U\\1", class(x), perl = TRUE), sep = "")
             if(is(x, "ExternalPrimitiveTypeArrayWithLength"))
               .Call(rName, x, as.integer(i), x@length)
             else
               .Call(rName, x, as.integer(i), as.integer(copy), x@length)[[1]]   # integer as (will) allow for a level of depth. XXX
           })



setMethod("[<-", c("ExternalArrayWithLength", "numeric"),
           function(x, i, j, ..., value) {
             if(any(i < 0 | i > length(x)))
               stop("subscripts out of bounds (must be between 1 and ", length(x), ")")
             w = (i == 0)
             if(any(w)) 
               i = i[!w]

                  # Handle replicating value, e.g. x[1:3] = 2
             if(length(i) < length(value))
               warning("number of items to replace is larger than number of elements being replaced")
             value = rep(value, length = length(i))

#XXX Avoid this!
if(!is.list(value))
  value = lapply(value, function(x) x)

             rName = paste("R_setSubset", gsub("^([a-z])", "\\U\\1", class(x), perl = TRUE), sep = "")
             .Call(rName, x, as.integer(i), value)
             x
           })

setMethod("[[<-", c("ExternalArrayWithLength", "numeric"),
           function(x, i, j, ..., value) {
             x[i] = list(value)
             x
           })



          # A call like x[i, ] or x[-(1:3), ], i.e. with j missing will be handled appropriately
          # by the regular method.
          # But when we have a second index, we have to do something

setMethod("[", c("ExternalTwoDimensionalArray", "missing", "missing"),
           function(x, i, j, ...,  copy = TRUE, drop = TRUE) {
             as(x, "array")
           })

setMethod("[", c("ExternalTwoDimensionalArray", "numeric",  "numeric"),
           function(x, i, j, ...,  copy = TRUE, drop = TRUE) {
             if(!copy) {
               stop("no implemented yet")
             }

             ans = callNextMethod()
             ans = lapply(ans, function(x) x[j])

             if(drop && length(i) == 1)
               ans = ans[[1]]
             if(drop && length(j) == 1) # length(ans) == 1)
               ans = ans[[1]]

              ans
           })


setMethod("[<-", c("ExternalTwoDimensionalArray", "numeric"),
           function(x, i, j, ..., value) {
             if(any(i < 0 || i > x@length[1]) ||  any(j < 0 || j > x@length[2]))
               stop("invalid subscripts for array")
if(is.vector(value) && !is.list(value))
  value = lapply(value, function(x) x)
else if(!is.null(getClassDef(class(value))))
  value = list(value)

             if(length(i) != length(j)) {
               stop("")
             }
             els = list(as.integer(i), as.integer(j))

             rName = paste("R_setCells", gsub("^([a-z])", "\\U\\1", class(x), perl = TRUE), sep = "")
             .Call(rName, x, els, value, x@length)             
           })


setMethod("[[<-", c("ExternalTwoDimensionalArray", "numeric"),
           function(x, i, j, ..., value) {
             if(any(i < 0 || i > x@length[1]) ||  any(j < 0 || j > x@length[2]))
               stop("invalid subscripts for array")
if(is.vector(value) && !is.list(value))
  value = lapply(value, function(x) x)
else if(!is.null(getClassDef(class(value))))
  value = list(value)

             els = list(...)
#browser()             
             rName = paste("R_setSubset", gsub("^([a-z])", "\\U\\1", class(x), perl = TRUE), sep = "")
             .Call(rName, x, as.integer(i), as.integer(j), value, x@length)
             x
           })

setMethod("dim", "ExternalTwoDimensionalArray",
            function(x) x@length)

setMethod("dim", "ExternalMultiDimensionalArray",
            function(x) x@length)


setAs("ExternalTwoDimensionalArray", "array",
      function(from) {
        d = dim(from)
        matrix(unlist(from[seq(along = from)]), d[1], d[2], byrow = TRUE)
      })

setAs("ExternalMultiDimensionalArray", "array",
      function(from) {
       els =  unlist(from[])
       tmp = base::array(els, rev(from@length))
       aperm(tmp, c(2,1, seq(along = from@length)[-(1:2)]))       
      })

#       ans = base::array(els, dim = from@length)
#       aperm(ans, c(2, 1, 3)       
#        aperm(base::array(els, rev(from@length), c(2,1, from@length[-(1:2)])))

# So that  ref[4:7] could actually turn into a reference to the same array but with the
# index information include.
setClass("ExternalArraySubset",
          representation(length = "integer",
                         offset = "integer"),
            contains = "ExternalArray")



setClass("charRefRef", contains = "ExternalArray")


setClass("VariableReference",
         representation("ref" = "RC++Reference"))





  # To define a new enum, we need the values and the coercion methods
  # Use of an enum that we define ourselves for specifying
  # which cast to make.
setClass("C++Cast", contains = "EnumValue")

  # This must be kept synchronized with the definition in inst/include/RConverters.h

`C++CastValues` = EnumDef("C++Cast", c("static" = 1, "dynamic" = 2, "reinterpret" = 3, "const" = 4))

setAs("character", "C++Cast",
        function(from)
            asEnumValue(from, `C++CastValues`, fromString = TRUE))

setAs("numeric", "C++Cast",
        function(from)
            asEnumValue(from, `C++CastValues`, fromString = FALSE))



# cast(a, "CPtr")
#  .Call("R_C_cast", from, how)
setGeneric("cast",
            function(from, to, how = `C++CastValues`['reinterpret'])
               standardGeneric("cast"))

setMethod("cast", c("ANY", "character"),
            function(from, to, how = `C++CastValues`['reinterpret']) {
               how = as(how, 'C++Cast')
               .Call(paste("R", gsub("Ptr$", "", to), "cast", sep = "_"), from, how)
            })

  # add a copy-depth parameter to control whether we copy the sub-content.
setGeneric("duplicate", function(x, ..., .finalizer = FALSE)
           standardGeneric("duplicate"))

setMethod("duplicate", "ExternalArrayWithLength",
          function(x, ..., .finalizer = FALSE) {
             if(is.na(x@elementSize))
               stop("Don't know the size of each element in the array")
             
             ref = .Call('R_duplicateArray', x, as.numeric(x@elementSize * x@length),  NULL)
             x@ref = ref

             if(is.logical(.finalizer) && !.finalizer)
               return(x)
             
             .finalizer = getNativeSymbolInfo(if(is.logical(.finalizer)) "SimpleAllocFinalizer" else as.character(.finalizer))$address

             addFinalizer(x, .finalizer)
             x
          })




setClass("CRoutineRef",
           representation(name = "character",
                          returnType = "character",
                          numParameters = "integer",
                          parameterTypes = "character"),
           contains = "RC++Reference")



setMethod("[", c("RCStructReference", "missing", "missing"),
           function(x, i, j, ...) {
              ids = names(x)
              structure(lapply(names(x), function(id) x[[id]]), names = names(x))
           })




setMethod("[", c("RCStructReference", "character", "missing"),
           function(x, i, j, ...) {
              structure(lapply(i, function(id) x[[id]]), names = i)
           })


setMethod("[[", c("RCStructReference", "character", "missing"),
           function(x, i, j, ...) {
               # this is a little inelegant, but it works for now.
               # We should create methods for each new class.
              eval(substitute(x$id, list(id = i)), sys.frame(sys.nframe()))
           })




setClass("size_t", contains = "numeric")
setAs("integer", "size_t", function(from) new("size_t", as.numeric(from))) # what about the names.
setAs("numeric", "size_t", function(from) new("size_t", from))

}
