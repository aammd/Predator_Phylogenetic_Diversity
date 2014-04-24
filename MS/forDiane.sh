# copy the latest bibliography from Mendeley's export
cp ~/Documents/Mendeley_reference_lists/pdpaper.bib ./pdpaper.bibtex
# Make the figure
# Make the manuscript
Rscript -e "library(knitr); knit('predatordiversity.Rmd')"

# write out a pretty word doc 
pandoc  -f markdown+citations+pipe_tables -t docx -H format.sty --reference-docx=reference.docx --bibliography=pdpaper.bibtex predatordiversity.md -o predatordiversity.docx