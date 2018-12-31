library(Rtesseract)

words = c("giving", "give", "giving", "gave", "giver", "govern")

if(require(Aspell)) {

Rtesseract:::spellFix("giviag", words) # from the corpus, 'sdagiving'

Rtesseract:::spellFix("giviag") # from the aspell alternatives
}


Rtesseract:::selfCorrect(wrong = "giviag", words = words)
