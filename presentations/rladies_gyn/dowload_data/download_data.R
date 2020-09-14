library(httr)
library(xml2)
library(rvest)
library(tidyverse)

url_base <- "https://transparencia.infraero.gov.br/"
url <- str_c(url_base, "estatisticas/")

table_html <- url %>% 
  httr::GET() %>% 
  httr::content("text") %>% 
  xml2::read_html() %>% 
  rvest::html_node('table')

links_to_download <- table_html %>% 
  rvest::html_nodes("a") %>% 
  rvest::html_attr("href")

link_table <- table_html %>% 
  rvest::html_table() %>% 
  pivot_longer(
    cols = X2:X13,
    names_to = "id",
    values_to = "month"
  ) %>% 
  filter(nchar(month) > 0) %>% 
  mutate(link = links_to_download) %>% 
  select(year = X1, month, link)


dest_folder <- "data/"
for(id_row in 1:nrow(link_table)){
  row_to_download <- slice(link_table, id_row)
  file_type <- str_extract(row_to_download$link, pattern = "\\.[^\\.]*$")
  
  download.file(
    url = stringr::str_c(url_base, row_to_download$link), 
    destfile = stringr::str_c(dest_folder, row_to_download$year, "_", row_to_download$month, file_type)
    )
}


