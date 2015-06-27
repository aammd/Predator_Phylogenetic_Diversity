## ggplot2 theme
mytheme <- theme_bw() + theme(strip.text = element_text(hjust = 0.01),
                              strip.background = element_blank(),
                              axis.title.y = element_blank(),
                              axis.text.x = element_text(size = 7))

one_point <- geom_point(colour = "black", 
                        fill = NA, shape = 21, colour = "black", 
                        size = 5, position = position_jitter(w = 0.1))
