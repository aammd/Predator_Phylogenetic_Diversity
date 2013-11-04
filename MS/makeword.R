# load knitr

library(knitr)


# ## first, make a .pdf file:
# render_markdown()
# opts_chunk$set(message=FALSE,warning=FALSE,echo=FALSE,fig.cap=FALSE,dev="png")

## knit the Rmd to a .md file
knit("predatordiversity.Rmd")

## make a .doc file
pandoc(input="predatordiversity.md",format="docx",config="predatordiversity.pandoc")
# debug(pandoc)