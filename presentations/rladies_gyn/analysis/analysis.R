library(tidyverse)
library(sweep)  
library(timetk)
library(forecast)

df <- read_csv("redefined/historico_aeroportos_atuais.csv")

df_total <- df %>% 
  group_by(data) %>% 
  summarise_if(is.numeric, sum) 

df_total_ts <- df_total %>% 
  select(data, emb_desemb_no_mes) %>% 
  filter(year(data) < 2020) %>% 
  tk_ts(frequency = 12, start = c(2012, 1))

fit_ets <- df_total_ts %>% 
  ets()

fcast_ets <- fit_ets %>%
  forecast(h = 12) 

data <- data %>% 
  mutate(model = "all")

data_before2020 <- data_before2020 %>% 
  filter(key != "actual")
data_before2020 <- data_before2020 %>% 
  mutate(model = "before2020")

df_plot <- bind_rows(data, data_before2020) %>% 
  filter(year(index) > 2016)

ribbon <- df_plot %>% 
  select(model, index, emb_desemb_no_mes) %>% 
  pivot_wider(
    names_from = model,
    values_from = emb_desemb_no_mes
  )

tibbon <- ribbon %>% 
  mutate(perc = 100*(before2020-all)/before2020)
  
ggplot(data = df_plot, aes(x = index)) +

  geom_ribbon(data = ribbon, aes(ymin = all, ymax = before2020), alpha = 0.5, fill = "#ead1dcff") +
  geom_line(aes(y = emb_desemb_no_mes,color = model), size = 1.5) +
  scale_y_continuous(labels = scales::comma) +
  scale_color_manual(values = c("#4c1130", "#c27ba0"))+
  geom_label(aes(x = 2021, y = 4e6, label = "Queda de 50%")) +
  theme_classic() 

df_train <- df_plot %>% 
  filter(year(data) < 2020) %>% 
  mutate(ts = ts(emb_desemb_no_mes, ))

ma <- sma(df_train$ts, h=12, silent=TRUE)
predict <- timetk::tk_tbl(ma$forecast) %>% 
  bind_rows(timetk::tk_tbl(ma$fitted)) %>% 
  mutate(data = as.Date(as.POSIXct(index)))

data <- predict %>% 
  mutate(forecast = value) %>% 
  select(data, forecast) %>% 
  full_join(df_plot)

data %>% 
  filter(year(data) >= 2018) %>% 
ggplot(aes(x = data)) +
  geom_line(aes(y = forecast)) +
  geom_point(aes(y = forecast)) +
  geom_line(aes(y = emb_desemb_no_mes )) 
