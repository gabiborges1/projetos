
#* Input
#* df - um data.frame
#* Output
#* df_resul - um data.frame com o nome das variáveis padronizados e strings em minúsculo
clear_strings <- function(df){
  df %>% 
    clean_names() %>% 
    mutate_if(is.character, stringr::str_to_lower)
}

read_infraero <- function(file, sheet){
  df <- read_excel(file, sheet = sheet, skip = 4, col_types = "text") 
  
  df <- df %>% 
    clear_strings() %>% 
    drop_na()
  
  id_aeroportos <- seq(1, nrow(df), by = 7)  
  
  df <- df %>% 
    filter(!(discriminacao %in% c("nacional", "regional", "pax de cabotagem"))) 
  
  df <- df %>% 
    mutate(nome_aeroporto = rep(df %>%  slice(id_aeroportos) %>% pull(discriminacao), each = 7)) 
  
  labels_transporte <- c(rep("transporte regular", 4), rep("transporte não regular", 3))
  tipo_transporte <- rep(labels_transporte, nrow(df)/length(labels_transporte))
  
  df <- df %>% 
    mutate(tipo_transporte = tipo_transporte) %>% 
    mutate(tipo_transporte = if_else(nome_aeroporto == discriminacao, "total", tipo_transporte)) %>% 
    mutate(tipo_voo = if_else(tipo_transporte == discriminacao | tipo_transporte == "total", "total", discriminacao)) %>% 
    select(-discriminacao) %>% 
    relocate(nome_aeroporto, tipo_transporte, tipo_voo) %>% 
    select(-contains("_ano")) %>% 
    mutate_at(vars(contains("_mes")), as.numeric) %>% 
    mutate(file_name = file)
  
  total <- df %>% 
    filter(nome_aeroporto == "infraero", tipo_transporte == "total", tipo_voo == "total") %>% 
    select(-nome_aeroporto, -tipo_transporte, -tipo_voo, -file_name)
  
  totalGroup <- df %>% 
    filter(nome_aeroporto != 'infraero') %>% 
    filter(tipo_transporte == "total", tipo_voo == "total") %>% 
    summarise_if(is.numeric, sum)
  
  diffTest <- sum(total - totalGroup)
  
  if(diffTest == 0){
    message("Criação de Variáveis: ", sheet ," OK")
  } else {
    warning("Total de linhas invalidos: ", sheet)
  }
  
  return(df)
}

create_month_data <- function(file, sheets =  c("Aeronaves", "Passageiros", "Correios")){
  list_df <- lapply(sheets, function(x) {
    read_infraero(file, x)
  })
  df_binded <- bind_cols(list_df, .name_repair = "minimal")
  message("Base ", file, ": Criada com sucesso")
  subset(df_binded, select = which(! duplicated(names(df_binded))))
}

geodesica2dec <- function(string){
  string %>%
    sub('°', 'd', .) %>%
    sub("'", '\'', .) %>%
    sub("''", '" ', .) %>%
    char2dms %>%
    as.numeric
}
