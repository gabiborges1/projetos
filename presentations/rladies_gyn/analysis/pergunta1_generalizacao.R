# Input
# df - Banco de dados
# var_name - Nome da métrica a ser calculada
# Output
# lista contendo dados das predições, dados do gráfico de área e percentual de redução do movimento
forecast_calculate <- function(df, var_name = "emb_desemb_no_mes") {
  df <- df %>% 
    group_by(data) %>% 
    summarise_if(is.numeric, sum)
  
  df_before_2020 <- df %>% 
    filter(year(data) < 2020)

  forecast_before <- df_before_2020 %>% 
    select(data, !!var_name) %>% 
    timetk::tk_ts(start = c(2012, 1), frequency = 12) %>% 
    ets() %>% 
    forecast(h = 20) %>% 
    sw_sweep(fitted = FALSE) %>% 
    mutate(model = "before2020") %>% 
    filter(key == "forecast")

  forecast_all <- df %>% 
    select(data, !!var_name) %>% 
    timetk::tk_ts(start = c(2012, 1), frequency = 12) %>% 
    ets() %>% 
    forecast(h = 13) %>% 
    sw_sweep(fitted = FALSE) %>% 
    mutate(model = "all")

  forecast_data <- bind_rows(forecast_all, forecast_before) %>% 
    select(-contains("."))  %>% 
    mutate(data = as.Date(as.POSIXct(index))) 
  
  ribbon_data <- forecast_data %>% 
    select(model, data, !!var_name) %>% 
    pivot_wider(
      names_from = model,
      values_from = !!var_name
    ) %>% 
    mutate(perc = round(100*(before2020-all)/before2020, 1)) %>% 
    drop_na()
  
  text_data <- ribbon_data %>% 
    filter(month(data) < 07 & perc > 0 & month(data) > 02 & year(data) == 2020) %>% 
    slice_max(order_by = perc) %>% 
    mutate(
      pos_y = (all + before2020) / 2,
      value_perc = perc,
      perc = str_c(perc, "% \n de redução")
    )
  
 #  forecast_data <- forecast_data %>% mutate(model = factor(model, levels = c("all", "before2020"), labels = "Atual", "Sem Covid19"))
   list(forecast_data = forecast_data, text_data = text_data, ribbon_data = ribbon_data)
}

# Input
# forecast_data - base de dados contendo as predições do modelo
# ribbon_data - base de dados contendo limite inferior e superior para gráfico de área
# text_data - dados com o percentual de redução
# Output
# lista contendo dados das predições, dados do gráfico de área e percentual de redução do movimento
draw_linechart <- function(forecast_data, ribbon_data, text_data, ...){
  var_name <- forecast_data %>% select_if(is.numeric) %>% names()
  
  ggplot(mapping = aes(x = data)) +
    geom_text(aes(x = as.Date("2020-02-01"), y = max(forecast_data[var_name]), label = "Fev. 2020")) +
    geom_vline(xintercept = as.Date('2020-02-01'), size = 0.7, color = "red", linetype = 3) +
    geom_ribbon(data = ribbon_data, aes(ymin = all, ymax = before2020), alpha = 0.5, fill = "#ead1dcff") +
    geom_line(
      data = filter(forecast_data, key == "forecast"),
      aes_string(y = var_name, color = "model"),
      size = 1, linetype = 4
    ) +
    geom_line(
      aes_string(y = var_name, color = "model"),
      data = filter(forecast_data, key == "actual"), size = 1.5
    ) +
    geom_text(data = text_data, aes(x = as.Date("2020-12-01"), y = pos_y, label = perc)) +
    scale_color_manual(values = c("#4c1130", "#c27ba0")) +
    theme_classic() +
    scale_y_continuous(labels = addUnits) +
    labs(x = "Data", ...) 
}
