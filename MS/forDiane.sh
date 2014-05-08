# copy the latest bibliography from Mendeley's export
cp ~/Documents/Mendeley_reference_lists/@MS_pdpaper.bib ./pdpaper.bibtex
# Make the figure
# Make the manuscript
Rscript -e "library(knitr); knit('predatordiversity.Rmd')"

# write out a pretty word doc 
pandoc  -f markdown+citations+grid_tables -t docx -H format.sty --reference-docx=reference.docx --bibliography=pdpaper.bibtex predatordiversity.md -o predatordiversity.docx

pandoc  -f markdown+citations+grid_tables -H format.sty --bibliography=pdpaper.bibtex predatordiversity.md -o predatordiversity.pdf
