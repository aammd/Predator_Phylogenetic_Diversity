# copy the latest bibliography from Mendeley's export
cp ~/Documents/Mendeley_reference_lists/pdpaper.bib .
# Make the figure
# Make the manuscript
Rscript -e "library(knitr); knit('predatordiversity.Rmd')"

# write out a pretty word doc for the boss :)
pandoc -H format.sty -s -S --reference-docx=reference.docx --bibliography=pdpaper.bib predatordiversity.md -o predatordiversity.docx

#pandoc -H format.sty -S --bibliography=predator\ diversity.bib predatordiversity_source.md -o predatordiversity_source.pdf


#pandoc -H margins.sty --bibliography git_ms.bib --csl plos.csl git_manuscript.md -o git_manuscript.tex
#pandoc -H margins.sty list_of_figures.md -o list_of_figures.tex

## look at it:

#evince predatordiversity-knitr.pdf
