library(Rtesseract)

words = c("giving", "give", "giving", "gave", "giver", "govern")

if(require(Aspell)) {

spellFix("giviag", words) # from the corpus, 'sdagiving'

spellFix("giviag") # from the aspell alternatives
}


Rtesseract:::selfCorrect(wrong = "giviag", words = words)
