library(janitor)
library(dplyr)
library(readxl)
library(purrr)
library(stringr)

source("aux_functions.R")
input_folder <- "data/"

list_paths <- str_c(input_folder, list.files(input_folder))
list_dfs <- list_paths %>% 
  map(create_month_data)

id_to_remove <- sapply(list_dfs, function(x) is.data.frame(x))

df_infraero <- list_dfs[id_to_remove] %>% bind_rows()

write.csv(df_infraero, "redefined/historico.csv")

df <- df_infraero %>% 
  mutate(
    ano = str_extract(file_name, pattern = "\\d+"),
    mes = str_extract(file_name, pattern = "(?<=_)(.*?)(?=\\.)")     
  ) %>% 
  filter(nome_aeroporto != "infraero", tipo_transporte != "total", tipo_voo != "total") %>% 
  select(-file_name) %>% 
  mutate(
    data_joined = str_c(ano, mes, "01", sep = "-"),
    data = ymd(data_joined)
  ) 

aeroportos_atuais <- df %>% 
  filter(ano == '2020', mes == "Jul") %>% 
  distinct(nome_aeroporto) %>% 
  pull(nome_aeroporto)

df_atuais <- df %>% 
  filter(str_detect(nome_aeroporto, pattern = str_c(aeroportos_atuais, collapse = "|"))) %>% 
  select(-data_joined, -mes, -ano) %>% 
  relocate(data) 

write.csv(df_atuais, "redefined/historico_aeroportos_atuais.csv")
