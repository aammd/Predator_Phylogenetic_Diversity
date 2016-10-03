all: MacDonald_romero_srivastava.pdf

MacDonald_romero_srivastava.pdf: *.tex *.bib
	pdflatex MacDonald_romero_srivastava
	bibtex MacDonald_romero_srivastava
	pdflatex MacDonald_romero_srivastava
	pdflatex MacDonald_romero_srivastava

tidy:
	rm -f *.aux *.log *.bbl *.blg

clean: tidy
	rm -f MacDonald_romero_srivastava.pdf
