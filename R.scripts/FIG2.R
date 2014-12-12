
library("dplyr")
library("magrittr")
library("reshape2")
library("ggplot2")
require("gridExtra")

## ggplot2 theme
mytheme <- theme_bw() + theme(strip.text = element_text(hjust = 0.01),
                              strip.background = element_blank(),
                              axis.title.y = element_blank())

one_point <- geom_point(colour = "black", 
                        fill = NA, shape = 21, colour = "black", 
                        size = 5, position = position_jitter(w = 0.1))

  

source("../R.scripts/FUNCTIONS_predator_diversity.R")

# experimental data
pd <- read.csv("../data/pd_exp_cleaned_data.csv",
               stringsAsFactors=FALSE) %>%   tbl_df()


# presence ----------------------------------------------------------------


pred_present <- pd %>%
  select(treatment, total.surv) %>%
  group_by(treatment) %>%
  summarise(trtmeans = mean(total.surv)) %>%
  mutate(ispred = ifelse(treatment == "control", "Absent", "Present")) %>%
  group_by(ispred) %>%
  mutate(presence_mean = mean(trtmeans))

pred_present_plot <- pred_present %>%
  mutate(plotcode = "(a)") %>%
  ggplot(aes(x = ispred, y = trtmeans)) + 
  one_point + 
  geom_point(aes(y = presence_mean), fill = "#00A08A", shape = 21, colour = "black", size = 5) + 
  #   geom_point(aes(y = total.surv), fill = NA, shape = 21, colour = "black", size = 5,
  #              data = subset(pred_present, treatment == "control")) + 
  xlab("Predator presence") + 
  facet_grid(~ plotcode) +
  mytheme


# number ------------------------------------------------------------------


pred_number <- pred_present %>% 
  filter(ispred == "Present") %>%
  mutate(npred = ifelse(grepl(" \\+ ", treatment), "Two", "One")) 

pred_number_plot <- pred_number %>%
  mutate(plotcode = "(b)") %>%
  ggplot(aes(x = npred, y = trtmeans)) +
  one_point + 
  stat_summary(fun.y = mean, fill = "#00A08A", shape = 21, size = 5, geom = "point") +
  xlab("Predator number") + 
  facet_grid(~ plotcode) +
  mytheme


# identity ----------------------------------------------------------------

releveler <- data_frame(treatment = c("andro", 
                         "tabanid", 
                         "elong + andro", 
                         "control", 
                         "leech", 
                         "elong + leech", 
                         "elong", 
                         "elong + tab"),
                        newlevels = c(
                          "La", 
                          "Tabanid", 
                          "Le + La", 
                          "control", 
                          "Leech",
                          "Le + Leech",
                          "Le",
                          "Le + Tabanid"))



preds <- pd %>%
  select(treatment, total.surv) %>%
  left_join(releveler) %>%
  mutate(treatment = factor(newlevels, 
                            levels = c("La","Le","Tabanid","Leech",
                                       "Le + La", "Le + Tabanid", "Le + Leech"))) %>%
  filter(treatment != "control") %>% 
  mutate(npred = ifelse(grepl(" \\+ ", treatment),
                        "Two species combination", "Monoculture"))

pred_identity <- preds %>%
  filter(npred == "Monoculture")

pred_identity_plot <- pred_identity %>%
  mutate(plotcode = "(c)") %>%
  ggplot(aes(x = treatment, y = total.surv)) +
  one_point + 
  stat_summary(fun.y = mean, fill = "#00A08A", shape = 21, size = 5, geom = "point") +
  xlab("Predator identity") +
  facet_grid(~ plotcode) +
  mytheme

# Combinations ------------------------------------------------------------


pred_combo <- preds %>%
  filter(npred == "Two species combination")


pred_combo_plot <- pred_combo %>%
  mutate(plotcode = "(d)") %>%
  ggplot(aes(x = treatment, y = total.surv)) +
  one_point + 
  stat_summary(fun.y = mean, fill = "#00A08A", shape = 21, size = 5, geom = "point") +
  xlab("Predator combination") +
  facet_grid(~ plotcode) + 
  mytheme

  
pdf("../Figures/FIG_2.pdf", height = 6, width = 6)
grid.arrange(pred_present_plot, pred_number_plot, pred_identity_plot, pred_combo_plot,
             ncol=2,
             left = textGrob("Mean prey survival", rot = 90, vjust = 1))
dev.off()