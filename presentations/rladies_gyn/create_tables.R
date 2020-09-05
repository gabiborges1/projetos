library(janitor)
library(dplyr)
library(readxl)
library(purrr)

source("drafts/aux_functions.R")
input_folder <- "drafts/data/"

list_paths <- str_c(input_folder, list.files(input_folder))
list_dfs <- list_paths %>% 
  map(possibly(create_month_data, NA))

id_to_remove <- sapply(list_dfs, function(x) is.data.frame(x))

df_infraero <- list_dfs[id_to_remove] %>% bind_rows()
