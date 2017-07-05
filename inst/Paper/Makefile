KNIT = Rscript -e "library(knitr); knit('$<')"

Rtesseract.pdf: Rtesseract.bib RJwrapper.tex
	pdflatex RJwrapper.tex
	bibtex RJwrapper
	pdflatex RJwrapper.tex
	pdflatex RJwrapper.tex
	mv RJwrapper.pdf Rtesseract.pdf

# This paper is built a bit strangely -
# RJwrapper.Rnw wraps the style for the R Journal
# and Rtesseract.Rnw
# Rtesseract.tex should not be created ever
RJwrapper.tex: RJwrapper.Rnw Rtesseract.Rnw
	$(KNIT)

clean:
	rm *.aux *.log *.out *.blg *.bbl *.brf RJwrapper.tex Rtesseract.pdf
