#
# Esse é a lógica do server de uma aplicação em Shiny.
# Você pode rodar a aplicação clicando en "Run App" aqui em cima /\.
#
# Pra mais informações sobre construção de aplicações em shiny:
#
#    http://shiny.rstudio.com/
#
# -------------> OBS: NÃO SE ESQUEÇA DE INSTALAR OS PACOTES ANTES <--------------

library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)
library(magrittr)

df <- read_csv("data.csv")

# Defina a lógica do server necessária pra construção do seu dashboard
shinyServer(function(input, output) {
    
    # Filtrando o dataset a medida que o usuário seleciona um input diferente.
    dataset <- reactive({
            df %>%
               filter(year == input$ano_selecionado)
    })

    # Fazendo gráfico de mapa
    # O mapa foi feito através da biblioteca leaflet. Mais informações em:
    #         https://rstudio.github.io/leaflet/
    output$map <- renderLeaflet({
        # O dataset
        plot_data = dataset()
        
        # O plot
        leaflet(
                data = plot_data,
                options = leafletOptions(attributionControl=FALSE)
        ) %>%   # Base do mapa
        addTiles() %>%   # Adiciona basemap 
        addMarkers(
            ~longitude, ~latitude,popup = ~as.character(burned_area),
            clusterOptions = markerClusterOptions(iconCreateFunction=JS(sum.formula))
        ) %>%   # Adiciona pontos
        setView(lng =  -51.92528, lat = -14.235004, zoom = 5)   # Zoom no Brasil
    })

    # Fazendo gráfico de linha
    # Esse gráfico foi feito através da biblioteca ggplot2. Mais informações em:
    #     https://ggplot2.tidyverse.org/ e https://livro.curso-r.com/8-1-o-pacote-ggplot2.html
    output$plot1 <- renderPlot({
        # O dataset
        plot_data <- dataset() %>%
            group_by(month) %>% 
            summarise(burned_area = sum(burned_area)) # Total de queimadas por mês

        # O plot
        ggplot(plot_data, aes(x = month, y = burned_area)) +
            geom_line(size = 1) + theme_bw() +
            labs(x = "Mês", y = "Área de Queimadas (km2)", title = "Total de área de queimadas (km2) por mês.") +
            scale_y_continuous(limits = c(0, 80000)) # Fixando escala pra facilitar comparação entre anos
    })

    # Fazendo gráfico de densidade
    # Esse gráfico foi feito através da biblioteca ggplot2. Mais informações em:
    #     https://ggplot2.tidyverse.org/ e https://livro.curso-r.com/8-1-o-pacote-ggplot2.html
    output$plot2 <- renderPlot({
        # O dataset
        plot_data <- dataset()

        # O plot
        ggplot(plot_data, aes(fill = basis_regions, x = Rh)) +
            geom_density(alpha = 0.6) + theme_bw() +
            theme(legend.position = c(0.8, 0.2)) +
            labs(x = "Respiração Heterotrófica", y = "Densidade", fill = "Tipo de Floresta:", title = "Respiração heterotrófica por tipo de floresta.")
    })
})


# Só uso essa função pra fazer o gráfico do mapa contar o total de área de queimadas
# Por default, o leaflet usa a contagens de pontos pra fazer o gráfico.
sum.formula  = JS("function (cluster) {    
    var markers = cluster.getAllChildMarkers();
    var sum = 0; 
    for (i = 0; i < markers.length; i++) {
      sum += Number(markers[i].options.popup);
    }
    var size = sum/10000;
    var formatted_number = Math.round(sum);
    
    var c = ' marker-cluster-';  
    if (formatted_number < 100) {  
      c += 'small';  
    } else if (formatted_number < 1000) {  
      c += 'medium';  
    } else { 
      c += 'large';  
    }    
    return new L.DivIcon({ html: '<div><span>' + formatted_number + '</span></div>', className: 'marker-cluster' + c, iconSize: new L.Point(40, 40) });
  }")
