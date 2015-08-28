## ggplot2 theme
maketheme <- function(){
  ggplot2::theme_bw() + 
    ggplot2::theme(strip.text = ggplot2::element_text(hjust = 0.01),
                   strip.background = ggplot2::element_blank(),
                   #axis.title.y = ggplot2::element_blank(),
                   axis.text.x = ggplot2::element_text(size = 7),
                   panel.grid.major = element_blank(),
                   panel.grid.minor = element_blank())
}

makept <- function(){
  set.seed(4812)
  ggplot2::geom_point(colour = "black", 
                      fill = NA, shape = 21,
                      size = 5, position = ggplot2::position_jitter(w = 0.1))
}