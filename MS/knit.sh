# copy the latest bibliography from Mendeley's export
cp ~/Documents/Mendeley_reference_lists/predator\ diversity.bib .
# Make the figure
# Make the manuscript
Rscript -e "library(knitr); knit('predatordiversity-knitr.Rmd')"
pandoc -s -S --bibliography predator\ diversity.bib predatordiversity-knitr.md -o predatordiversity-knitr.docx
#pandoc -s -S predatordiversity-knitr.md -o predatordiversity-knitr.pdf

## make the figures
#Rscript -e "library(knitr); knit('predatordiversity-knitr_figs.Rmd')"
#pandoc -s -S predatordiversity-knitr_figs.md -o predatordiversity-knitr_figs.pdf


# Combine the two 
#pdfunite predatordiversity-knitr.pdf predatordiversity-knitr_figs.pdf predatordiversity-knitr_MS.pdf
# Remove duplicate files and rename concated one to original name
#rm predatordiversity-knitr.pdf
#rm predatordiversity-knitr_figs.pdf
# rm git_manuscript.pdf
# mv git_ms.pdf git_manuscript.pdf

#pandoc -H margins.sty --bibliography git_ms.bib --csl plos.csl git_manuscript.md -o git_manuscript.tex
#pandoc -H margins.sty list_of_figures.md -o list_of_figures.tex

## look at it:

#evince predatordiversity-knitr.pdf