# Sobre

O curso de ggplot2 foi um curso expositivo e o objetivo era responder duas perguntas sobre a redução da movimentação aérea durante a crise do Covid. A idéia é que essas perguntas sejam respondidas utilizando visualização de dados. Os scripts foram desenvolvidos usando o R e bibliotecas do tidyverse. As perguntas eram: 
1. Qual o percentual de queda da movimentação dos aeroportos na crise covid?
2. Houveram aeroportos com maior queda de movimentação do que outros?

# Informações

- Os dados foram extraídos através de script de webscrapping do site oficial da [infraero](https://transparencia.infraero.gov.br/estatisticas/). Os scripts de webscrapping estão disponíveis na pasta **download_data/**. 
- Os slides estão disponivéis no [link](https://docs.google.com/presentation/d/1QL9epxVU3Gu12i14IPLTQ3_enEF9NPpzoUxZREL6d_g/edit#slide=id.g4c68a97855_1_104)
- Durante o curso, tivemos problema com a base de dados pois estavam faltando informações de alguns meses. O banco de dados atualizado e completo está disponível na pasta **redefined/**.

# Respostas

## 1. Qual o percentual de queda da movimentação dos aeroportos na crise covid?

Utilizamos o modelo de série temporal que leva em consideração o erro, tendẽncia e sazonalidade (ets) para predizer o que deveria ter acontecido com o movimento dos aeroportos se não houvesse covid e predizer o que vai acontecer pós crise. A diferença do que aconteceria vs o que aconteceu é justamente a redução da movimentação.
Os scripts das análises para pergunta 1 estão disponíveis na pasta **analysis/**. O script **pergunta1.R** foi construído durante o curso. O script **pergunta1_generalizacao.R** generaliza as análises para que elas sejam rodadas para todas as métricas da base de dados.

**GRÁFICO**: Redução da movimentação nos aeroportos administrados pela infraero durante crise do covid19, Janeiro de 2012 a Julho de 2020.
<p align="center" width="100%">
    <img src="https://github.com/gabiborges1/projetos/blob/master/presentations/rladies_gyn/analysis/pergunta1.png"> 
</p>

Algumas conclusões:
1. Houve uma redução de **96%** na movimentação de pessoas, **71%** de redução do número total de voos e **35%** de redução nas cargas do correios.
2. Nos últimos meses, antes da crise covid havia um tendência de queda no número de voos e aumento do número de pessoas, indicando um possível correlação positiva entre essas duas métricas. *Em outras palavras, os voos estavam ficando mais lotados*.
3. O número de cargas do correios já estava com um comportamento de queda nos meses pré-covid e foi a **métrica menos impactada**. Houve uma recuperação na movimentação das cargas em maio na seguida de queda brusca em julho (por que será? greve dos correios? ninguem mais quer comprar com entrega pelos correios?).


## 2. Houveram aeroportos com maior queda de movimentação do que outros?

Utilizamos o mesmo modelo de série temporal que leva em consideração o erro, tendẽncia e sazonalidade (ets) para predizer o que deveria ter acontecido com o movimento dos aeroportos se não houvesse covid e predizer o que vai acontecer pós crise. A diferença do que aconteceria vs o que aconteceu é justamente a redução da movimentação.
Os scripts das análises para pergunta 2 estão disponíveis na pasta **analysis/**. O script **pergunta2.R** contém o código para geração do gráfico. O script **pergunta1_generalizacao.R** foi utilizado por conta da generalização das análises para que elas sejam rodadas para todos os aeroportos da base de dados.

**GRÁFICO**: Percentual de redução da movimentação de *passageiros* nos aeroportos administrados pela infraero durante crise do covid19, Janeiro de 2012 a Julho de 2020.
<p align="center" width="100%">
    <img src="https://github.com/gabiborges1/projetos/blob/master/presentations/rladies_gyn/analysis/pergunta2.png"> 
</p>

Algumas conclusões:
1. **86%** dos aeroportos tiveram mais de **60%** de redução no número de passageiros frequentando o aeroporto durante a crise de covid.
2. Os aeroportos que foram menos impactados do que outros são aeroportos pequenos com pouca movimentação de pessoas.
3. Os aeroportos de Pampulha (BH) e Jacarépaguá (RJ) são os maiores aeroportos menos impactados pela crise do covid com redução de **39%** e **54%** na movimentação de pessoas, respectivamente.

# Limitações

- É extremamente reforçar que os cálculos utilizados levam em consideração apenas os aeroportos administrados pela Infraero.
- As características dos aeroportos não foram levadas em consideração. Então as métricas aqui calculadas não podem ser intepretadas como impacto do covid na movimentação dos aeroporotos. 
- O modelo de predição só foi utilizado para fins de visualização da tendẽncia do comportamento. Para utilização do modelo em contexto de predição é necessário que se faça as etapas de machine learning (treino, teste, validação, padronização, ...)

# E agora?

- Essa base é riquíssima e da pra fazer muitas análises. Se sinta livre para usar a base aqui disponível em suas aulas, apresentações, aplicativos shiny, tcc, dissertação, scripts para aprender, e o que vocês quiserem. Apenas peço que sejam citados o site oficial  da infraero e este repositório no momento do uso.
- Construiu um projeto legal com essa base? Uma visualização? Me manda para eu ver pelo linkedIn ou por email ^.^

