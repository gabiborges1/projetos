# Folder MIAS 
Contém as imagens originais e as imagens resultantes de cada etapa de pré-processamento.

# etapa-1-preprocessamento.ipynb
Remove pixels da borda das imagens.
Linguagem: R.

# etapa-2-remocao-sujeiras.ipynb
Remove objetos não desejados e ruídos das imagens.
Primeiro é feito um mapeamento dos objetos da imagen através do mapeamento por threshold, em seguida é extraido maior polígono da imagem binária resultante, por fim, é feito um merge entre a imagem original e a imagem binária contendo o maior polígono. O resultado é uma imagem da mama sem objetos indesejados. 
Linguagem: Python.

# etapa-3-resize-imagens.ipynb
Reduz resolução das imagens usando a metodologia de vizinho mais próximo.
Linguagem: R.

# etapa-4-analise-CNN.ipynb
Organiza arquivos, seta e treina as CNN's nas imagens.
Linguagem: Python.
