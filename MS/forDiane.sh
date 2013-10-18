# copy the latest bibliography from Mendeley's export
cp ~/Documents/Mendeley_reference_lists/predator\ diversity.bib .
# Make the figure
# Make the manuscript
Rscript -e "library(knitr); knit('predatordiversity_source.Rmd')"

# write out a pretty word doc for the boss :)
~/.cabal/bin/pandoc -H format.sty -V fontsize=12pt -s -S --bibliography=predator\ diversity.bib predatordiversity_source.md -o predatordiversity_source.docx

~/.cabal/bin/pandoc -H format.sty -V fontsize=12pt -s -S --bibliography=predator\ diversity.bib predatordiversity_source.md -o predatordiversity_source.pdf


#pandoc -H margins.sty --bibliography git_ms.bib --csl plos.csl git_manuscript.md -o git_manuscript.tex
#pandoc -H margins.sty list_of_figures.md -o list_of_figures.tex

## look at it:

#evince predatordiversity-knitr.pdf
