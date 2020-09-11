library(lubridate)
  
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
  filter(str_detect(nome_aeroporto, pattern = str_c(aeroportos_atuais, collapse = "|")))

df_plot <- df_atuais %>% 
  group_by(data) %>% 
  summarise_if(is.numeric, sum)

df_plot %>% 
  ggplot(aes(x = data, y = emb_desemb_no_mes)) + geom_line()

glimpse(df_plot)
