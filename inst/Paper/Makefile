Rtesseract.pdf: Rtesseract.bib RJwrapper.tex 
	pdflatex RJwrapper.tex
	bibtex RJwrapper
	pdflatex RJwrapper.tex
	pdflatex RJwrapper.tex
	mv RJwrapper.pdf Rtesseract.pdf

RJwrapper.tex: RJwrapper.Rnw Rtesseract.Rnw
	Rscript -e "library(knitr);knit('RJwrapper.Rnw')"

Rtesseract.tex: Rtesseract.Rnw
	Rscript -e "library(knitr);knit('Rtesseract.Rnw')"

clean:
	rm Rtesseract.aux Rtesseract.log Rtesseract.out Rtesseract.blg
