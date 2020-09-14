# Pacotes
library(tidyverse)
library(sweep)  
library(timetk)
library(forecast)
library(lubridate)

# Ler a base
df <- read_csv("redefined/historico_aeroportos_atuais.csv")
glimpse(df)

# Gráfico exploratório
df_total <- df %>% 
  group_by(data) %>% 
  summarise_if(is.numeric, sum)

df_total %>% 
  select(data, pou_dec_no_mes, emb_desemb_no_mes, car_descar_no_mes) %>% 
  pivot_longer(
    cols = !data,
    names_to = "variavel",
    values_to = "metrica"
  ) %>% 
  ggplot2::ggplot(mapping = aes(x = data, y = metrica)) +
  geom_vline(aes(xintercept = as.Date("2020-02-01")), linetype = 2, color = "red") +
  geom_line() +
  facet_wrap(~variavel, scale = "free") + 
  theme_classic() +
  scale_y_continuous(labels = addUnits) +
  labs(x = "Data", y = "Valor")

# Modelo de predição (todos os dados, dados antes de 2020)
df_before_2020 <- df_total %>% 
  filter(year(data) < 2020)

forecast_before <- df_before_2020 %>% 
  select(data, emb_desemb_no_mes) %>% 
  timetk::tk_ts(start = c(2012, 1), frequency = 12) %>% 
  ets() %>% 
  forecast(h = 20) %>% 
  sw_sweep(fitted = FALSE) %>% 
  mutate(model = "before2020") %>% 
  filter(key == "forecast")

forecast_all <- df_total %>% 
  select(data, emb_desemb_no_mes) %>% 
  timetk::tk_ts(start = c(2012, 1), frequency = 12) %>% 
  ets() %>% 
  forecast(h = 13) %>% 
  sw_sweep(fitted = FALSE) %>% 
  mutate(model = "all")

forecast_data <- bind_rows(forecast_all, forecast_before) %>% 
  select(-contains("."))  %>% 
  mutate(data = as.Date(as.POSIXct(index))) 

ribbon_data <- forecast_data %>% 
  select(model, data, emb_desemb_no_mes) %>% 
  pivot_wider(
    names_from = model,
    values_from = emb_desemb_no_mes
  ) %>% 
  mutate(perc = round(100*(before2020-all)/before2020), 8) %>% 
  drop_na()

text_data <- ribbon_data %>% 
  filter(month(data) < 07 & perc > 0 & month(data) > 02) %>% 
  slice_max(order_by = perc) %>% 
  mutate(
    pos_y = (all + before2020) / 2,
    perc = str_c(perc, "% \n de redução")
    )

ggplot(mapping = aes(x = data)) +
  geom_ribbon(data = ribbon_data, aes(ymin = all, ymax = before2020), alpha = 0.5, fill = "#ead1dcff") +
  geom_line(
    data = filter(forecast_data, key == "forecast"),
    aes(y = emb_desemb_no_mes, color = model),
    size = 1, linetype = 4
    ) +
  geom_line(
    aes(y = emb_desemb_no_mes, color = model),
    data = filter(forecast_data, key == "actual"), size = 1.5
    ) +
  geom_text(data = text_data, aes(x = as.Date("2020-12-01"), y = pos_y, label = perc)) +
  scale_color_manual(values = c("#4c1130", "#c27ba0")) +
  theme_classic() +
  scale_y_continuous(labels = addUnits) +
  labs(x = "Data", y = "Valor") +
  guides(color = F)
  