#
# Functions
#


selfGuessWord = 
function(ctr, wrong = character())
{
   k = ctr[ !(names(ctr) %in% wrong)]
   if(length(k) == 0)
       NA
   else
       names(k)[ k == max(k) ]
}





selfCorrect =
    # The idea here is to OCR one or more documents and then find the words
    # that are "wrong" (e.g. we might do this with a spell checker or just compare all words) - and then
    # see if there are other words that are similar to these that are correct/valid.
    #
    #
function(boxes, wrong = character(), words = lapply(boxes, `[[`, "text"), files = names(boxes),
         sim = getSimilarWords(words))
{
    if(length(wrong) == 0) {
        sp = Aspell::aspell(names(sim))
        wrong = names(sim)[!sp]
    }
    
    fix = structure(lapply(sim[wrong], selfGuessWord, wrong = wrong), names  = wrong)
}

getSimilarWords =
function(words, distThreshold = 3)
{
   aw = table(cleanWords(unlist(words)))
   D = adist(names(aw), names(aw))
   rownames(D) = names(aw)
   sim = apply(D, 1, function(x) aw[ x > 0 & x < distThreshold ])
}


spellFix =
function(wrong, words = character())
{
    ok = aspell(wrong)
    wrong = wrong[!ok]
    if(length(wrong)) {
        alt = aspell(wrong, TRUE)
        if(length(words)) {
            freq = table(words)
            lapply(alt, function(a) {
                           if(any(w <- a %in% names(freq))) {
                               tmp = freq[a[w]]
                               names(tmp)[ tmp == max(tmp) ]
                           } else
                               a
                        })
        } else
            alt
    } else
        list()
}

cleanWords =
function(x)
{
  gsub("[[:punct:]]$", "", x)
}
