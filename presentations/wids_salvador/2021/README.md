# Sobre

O minicurso de shiny é um curso expositivo. A ideia é entender sobre os principais conceitos de um dashboard em Shiny.
1. User Interface - UI
2. Server

# Como rodar a aplicação?

- Instale o R ([Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-r-on-ubuntu-20-04-pt), [Windows](https://cran.r-project.org/bin/windows/base/))
- Instale o Rstudio ([Ubuntu](https://www.edivaldobrito.com.br/rstudio-no-linux/), [Windows](https://www.rstudio.com/products/rstudio/download/))
- Instale os pacotes necessários
  - No Rstudio, rode: `install.packages(c("dplyr", "shiny", "leaflet", "ggplot2"))`  
- Setar como working diretório a pasta contendo os arquivos server.R, ui.R e data.csv
  - `setwd("~/pasta/contendo/server/e/ui/files")` 
- Abra os arquivos ui.R e server.R no Rstudio
- Clicar no botão _Run App_ no canto superior direto.

# Informações

- Os dados foram extraídos do site do [Kagle](https://www.kaggle.com/mateus558/brazilian-legal-amazon-burned-area-dataset?select=gfed_1998_2016_w_fire_spots.csv). Contém informações sobre as queimadas na Amazỗnia Legal. 
- Os slides estão disponivéis no [link](https://docs.google.com/presentation/d/13A3hmwjsjCDBR4A-qUWHObwqGlmi2NGLAFpHc4D-c_s/edit?usp=sharing)

# E agora?

- Se sinta livre para usar, mudar, alterar, copiar o dashboard estudado (Inclusive enviar PR pro repositório)
- Construiu um projeto legal com essa base? Uma visualização? Me manda pelo linkedIn ou por email ^.^

# Onde aprender? 

- [curso-R](https://www.curso-r.com/)
- [shiny](https://shiny.rstudio.com/)
- [golem](https://cran.r-project.org/web/packages/golem/vignettes/a_start.html)
- [leaflet](https://rstudio.github.io/leaflet/)
- [Advanced R](https://adv-r.hadley.nz/)
- [ggplot2](https://ggplot2-book.org/)
