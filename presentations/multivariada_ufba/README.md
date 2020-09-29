# Sobre o banco de dados

O banco de dados foi obtido no site do portal INEP. Baixei os microdados do ENEM referentes ao ano de 2016 e calculei as métricas de nota média das provas feitas para cada município [link](http://portal.inep.gov.br/web/guest/microdados) do estado da Bahia e de Pernambuco.
Os dados originais contém informações sociodemográficas e de desempenho de cada uma das pessoas que fizeram a prova.

- *CO_MUNICIPIO_RESIDENCIA* - Codigo de município de residência
- *uf_res* - Codigo de estado de residencia (26 - Pernambuco, 29 - Bahia)
- *nu_nota_cn* - Nota média do município na prova de ciências naturais
- *nu_nota_ch* - Nota média do município na prova de ciências humanas
- *nu_nota_lc* - Nota média do município na prova de linguagens e códigos
- *nu_nota_mt* - Nota média do município na prova de matemática
- *nu_nota_redação* - Nota média do município na prova de redação

# Perguntas

As perguntas a serem respondidas eram:

- Existem municípios com desempenhos parecidos na Bahia? (Análise de agrupamento)
- Existe diferença no desempenho médio dos municípios da Bahia em relação ao municípios de Pernambuco? (Análise discriminante)

# 1. Análise de agrupamento

Veja na figura abaixo que as variáveis de nota estão altamente correlacionadas, ou seja, os municípios tendem a ter desempenho semelhante em todas as materias. 
Um indicador de que não existem municípios com desemepnho alto em matemática e péssimo em redação (por exemplo.). 
Além disso, a característica da métrica ser uma média de uma variável contínua fez com que ela tivesse tendência de comportamento simétrico.

<p align="center" width="100%">
    <img src="https://github.com/gabiborges1/projetos/blob/master/presentations/multivariada_ufba/agrupamento_files/figure-html/unnamed-chunk-3-1.png"> 
</p>


Os metódos de agrupamento não hierárquico foram utilizados para identificarmos descritivamente o número de clusters necessários para agrupar os municípios da Bahia.
Os resultados dos algoritmos não hierárquicos corroboram para um número de cluster entre 2 a 4. 
Foram feitos testes com os métodos não hieráquicos (K-means) utilizando esses número de clusters.
O melhor cluster será escolhido com base na proporção de variabilidade entre cluster comparada com a variabilidade total.

Os métodos não-hierárquicos da análise de cluster são caracterizados pela necessidade de definir uma partição inicial e pela flexibilidade, uma vez que os elementos podem ser trocados de grupo durante a execução do algoritmo.
Decidimos selecionar 3 grupos de cluster e podemos interpretá-los como municípios com desempenho baixo, médio e alto.

<p align="center" width="100%">
    <img src="https://github.com/gabiborges1/projetos/blob/master/presentations/multivariada_ufba/agrupamento_files/figure-html/unnamed-chunk-13-1.png"> 
</p>

## Visualizando resultado

Pra finalizar essa análise, gostaríamos de ver os grupos formados em um mapa pra indentificar possíveis padrões de desempenho em localizações dos municípios da Bahia.

<p align="center" width="100%">
    <img src="https://github.com/gabiborges1/projetos/blob/master/presentations/multivariada_ufba/agrupamento_files/figure-html/unnamed-chunk-15-1.png"> 
</p>

