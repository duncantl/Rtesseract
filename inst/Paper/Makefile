KNIT = Rscript -e "library(knitr); knit('$<')"

Rtesseract.pdf: Rtesseract.bib RJwrapper.tex Rtesseract.tex
	pdflatex RJwrapper.tex
	bibtex RJwrapper
	pdflatex RJwrapper.tex
	pdflatex RJwrapper.tex
	mv RJwrapper.pdf Rtesseract.pdf

%.tex: %.Rnw 
	$(KNIT)

clean:
	rm *.aux *.log *.out *.blg
