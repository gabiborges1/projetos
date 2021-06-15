#
# Essa é a definição de interface de usuário de uma aplicação Shiny.
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

# Definição do UI
shinyUI(tagList(
    # Style geral da página
    tags$style("html, body {margin: 0; background-color:black}"),

    # Div que vai conter o mapa
    tags$div(
        width="100vw", height="100vh", style = "background-color:lightpink",

        leaflet::leafletOutput("map", width="100vw", height="100vh"),
    ),

    # Div com card lateral
    absolutePanel(
        id = "plot_div", class = "panel panel-default", fixed = TRUE,
        top = 10, right = 10, width = "400px", height = "auto",
        style = "background-color: rgba(255,255,255,0.9); padding: 10px; border-radius: 10px",

        tags$h2("Incêndios florestais na Amazônia, 2011 a 2013"),
        hr(),

        # Select de ano
        selectInput(
            inputId = "ano_selecionado",
            label = "Selecione um ano:",
            choices = c(2011, 2012, 2013),
            selected = 2013,
            width = "100%"
        ),

        # Plots
        plotOutput(outputId = "plot1", height = "350px"),
        plotOutput(outputId = "plot2", height = "350px"),
    ),
))
