# Pacotes
library(tidyverse)
library(sweep)  
library(timetk)
library(forecast)
library(lubridate)
library(ggpubr)
library(gridExtra)
library(sf)

# Chamando funções do script Aux_functions
source("analysis/aux_functions.R")

# Ler a base
df <- read_csv("redefined/historico_aeroportos_atuais.csv")
glimpse(df)

# Vou usar a função forecast_calculate do pergunta1_generalização porque ele guarda uma função que calcula o forecast de maneira
# Para a base da infraero
source("analysis/pergunta1_generalizacao.R")

# Organizando a base de dados para rodar a métrica de redução para todos os aeroportos
df_nested <- df %>% 
  # Selecionando somente variáveis relevantes e uma métrica 
  select(data, nome_aeroporto, emb_desemb_no_mes) %>% 
  # Agrupando pelo nome do aeroporto
  group_by(nome_aeroporto) %>% 
  # Fazendo nest das bases de cada aeroporto
  nest() %>% 
  # Rodando calculo do forecast de redução para cada aeroporto
  mutate(., results = map(data, forecast_calculate)) %>% 
  select(-data) 


df_reducao <- df_nested %>%
  # Pegando base com os percentuais de redução
  mutate(., text_data = map(results, pluck, 2)) %>% 
  select(-results) %>% 
  # Retornando base para formato linha/coluna
  unnest(
    cols = text_data
  ) %>% 
  ungroup()

# Lendo base com informação sobre localização dos aeroportos
df_aeroportos <- read_csv("redefined/aeroportos.csv")

# Juntando as bases 
df_joined <- left_join(df_reducao, df_aeroportos, by = c("nome_aeroporto" = "aeroporto")) %>% 
  mutate(flag_menos_reducao = value_perc < 60)

# Lendo shapefile para basemap
shp <- st_read("redefined/shp/UFEBRASIL.shp")

ggplot() +
  geom_sf(data = shp, fill = "white", color = "#ead1dc") +
  geom_point(
    data = df_joined %>% filter(flag_menos_reducao),
    aes(x = latitude, y = longitude, color = value_perc, size = value_perc),
    alpha = 0.5, size= 15) +
  geom_text(
    data =  df_joined,
    aes(x = latitude, y = longitude, color = value_perc, size = value_perc, label = mun),
    vjust = -1) + 
  geom_text(
    data = df_joined,
    aes(x = latitude, y = longitude, color = value_perc, size = value_perc, label = value_perc)) + 
  guides(color = FALSE, size = FALSE) +
  scale_size_continuous(trans = "reverse", range = c(2, 6)) +
  scale_color_gradient(low = "#ead1dc", high = "#a64d79", trans = "reverse") + 
  theme_void() 


