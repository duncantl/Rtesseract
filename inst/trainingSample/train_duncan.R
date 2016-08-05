## Script to train tesseract
## M. Espe
## Aug 2016

# setwd("~/DSI/PlantTables/training/")

system("tesseract eng.tables.exp0.png eng.tables.exp0 batch.nochop makebox")


doc <- readLines("1990_p44.txt")
doc <- gsub(" ", "", doc)
chars <- unlist(strsplit(doc, ""))


library(Rtesseract)
bb = readBoxFile("eng.tables.exp0.box")
plot(bb)


## Got to remove those boxes that span the width of the table
rr = bb[ bb[, "text"] == "~", ]
rect(rr[,1], rr[, 2], rr[, 3], rr[, 4], col = "red")

rect(bb[53:54,1], bb[53:54,2], bb[53:54,3], bb[53:54,4], col = "red")
rect(bb[695,1], bb[695,2], bb[695,3], bb[695,4], col = "red")


lens <- bb[,3] - bb[,1]
lens[lens>1000]

boxlines <- boxlines[!(lens > (2*mean(lens))),]

## Insert correct characters
boxlines[,1] <- chars

write.table(boxlines, file = "eng.tables.exp0.box",
            sep = " ", quote = FALSE,
            row.names = FALSE, col.names = FALSE)

system("tesseract eng.tables.exp0.png eng.tables.exp0 box.train")
system("unicharset_extractor eng.tables.exp0.box")
system("set_unicharset_properties -U input_unicharset -O output_unicharset --script_dir=training/langdata")

writeLines("table 0 0 1 0 0", con = "font_properties")

system("mftraining -F font_properties -U unicharset -O eng.unicharset eng.tables.exp0.tr")

system("cntraining eng.tables.exp0.tr")

## Generate the list of characters that might be confused
writeLines(c("v2\nW MM 0",
             "0 O 0",
             "O 0 0"), con = "unicharambigs")
list.files()

# I'd do a file.rename() here
system('for f in shapetable normproto inttemp pffmtable unicharset unicharambigs; do mv "$f" "eng.$f"; done')
system("combine_tessdata eng.")
