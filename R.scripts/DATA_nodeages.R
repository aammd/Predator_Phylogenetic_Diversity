library("dplyr")
library("magrittr")

list.files(path="../raw-data/TreeData",
                       pattern="*.csv",
                       full.names=TRUE) %>%
  data.frame(paths = .,stringsAsFactors = FALSE) %>%
  mutate(nodename = basename(paths) %>% gsub(".csv","",.)) %>%
  group_by(nodename) %>%
  do(age_data = read.csv(.$paths)) %>%
  mutate(Nstudies = nrow(age_data),
         minT = min(age_data %>% extract2("Time")),
         maxT = max(age_data %>% extract2("Time"))) %>%
  select(-age_data) %>%
  write.csv(file="../data/nodeages.csv", row.names=FALSE)

