# load knitr

library(knitr)

## first, make a .pdf file:
# render_markdown()
# opts_chunk$set(message=FALSE,warning=FALSE,echo=FALSE,fig.cap=FALSE,dev="pdf")

## knit the Rmd to a .md file
knit("predatordiversity.Rmd")

## make the pdf
pandoc(input="predatordiversity.md",format="latex",config="predatordiversity.pandoc")


# ## first, make a .pdf file:
# render_markdown()
# opts_chunk$set(message=FALSE,warning=FALSE,echo=FALSE,fig.cap=FALSE,dev="png")

## knit the Rmd to a .md file
knit("predatordiversity.Rmd")

## make a .doc file
pandoc(input="predatordiversity.md",format="docx",config="predatordiversity.pandoc")


knit2("predatordiversity.Rmd",out='html')


if (TRUE) {
  render_markdown()
  opts_chunk$set(dev = 'pdf')
  knit('predatordiversity.Rmd')
  # now it should be better
  pandoc('predatordiversity.md', format = 'latex')
}