library(lubridate)
  
df_plot <- df_atuais %>% 
  group_by(data) %>% 
  summarise_if(is.numeric, sum) 

df_train <- df_plot %>% 
  filter(year(data) < 2020) %>% 
  mutate(ts = ts(emb_desemb_no_mes, frequency = 12, start = c(2012, 1)))

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
