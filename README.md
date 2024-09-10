<h1 align="center">Sistema de Vigilância de Fatores de Risco e Proteção para Doenças Crônicas
por Inquérito Telefônico (Vigitel)</h1>
<p align="center"><i>Repositório para documentação do tratamento de dados para a vaga de Analista de Avaliação de Impacto - ImpulsoGov.</i></p>

# Problema
"Qual o percentual de mulheres sem plano de saúde que não haviam feito preventivo de câncer de colo de útero (exame papanicolau) há mais de três anos nas capitais brasileiras?"

# Base
Fonte: https://svs.aids.gov.br/download/Vigitel/

# Ferramentas
Python, Google Colab, R, RStudio e Excel

# Lógica
Entende-se aqui que o objetivo é investigar tanto as mulheres que haviam feito exame papanicolau (mas há mais de três anos) como aquelas que não haviam feito o exame em nenhum momento.

Assim, a resposta é uma proporção (%) entre:
- Numerador: soma do (1) total de mulheres sem plano de saúde que haviam feito preventivo de câncer de colo de útero (exame papanicolau) há mais de três anos nas capitais brasileiras e (2) do total de mulheres sem plano de saúde que não haviam feito preventivo de câncer de colo de útero (exame papanicolau) 
- Denominador: total de mulheres sem plano de saúde 

Considera-se o DF como capital brasileira nessa análise. Mesmo os dados sendo de uma pesquisa de amostragem complexa, será realizada a proporção com o tratamento na amostra apenas, com o R.

# Metodologia de tratamento
1. Preparo com o estudo das [orientações sobre o uso das bases de dados](https://svs.aids.gov.br/download/Vigitel/Orientacoes-sobre-o-uso-das-bases-de-dados.pdf)

2. Carregamento dos dados de 2023 ("Vigitel-2023-peso-rake.xlsx") e dicionário de dados ("Dicionario-de-dados-Vigitel.xls")

3. Seleção de variáveis no Excel para resolução do problema:

|Nome da variável|Descrição da variável| 
|----------------|------------------| 
|q7|sexo| 
|q88|posse de plano de saúde| 
|q79a|papanicolau| 
|q80|tempo do último exame de papanicolau|

4. Abertura da base de dados no Google Colab com o Python (dificuldades de leitura da base no R, corrompendo o formato das variáveis de interesse, que foram corrigidos no Python)

5. Seguindo as orientações da Vigitel, utiliza-se "pesorake" para trabalhar com os pesos no pacote "survey" do R e definir o desenho amostral. 

6. Filtro para cálculo do denominador:

|Nome da variável|Descrição da variável| Filtro|
|----------------|------------------| ------|
|q7|sexo| 2 - "feminino"|	
|q88|posse de plano de saúde| 3	- "não"|

7. Filtro para cálculo do numerador (1):

|Nome da variável|Descrição da variável| Filtro|
|----------------|------------------| ------|
|q7|sexo| 2 - "feminino"|	
|q88|posse de plano de saúde| 3	- "não"|
|q79a|papanicolau| 1 - "sim"|
|q80|tempo do último exame de papanicolau|4 - "entre 3 e 5 anos"<br>5 - "5 anos ou mais"|

8. Filtro para cálculo do numerador (2):

|Nome da variável|Descrição da variável| Filtro|
|----------------|------------------| ------|
|q7|sexo| 2 - "feminino"|	
|q88|posse de plano de saúde| 3	- "não"|
|q79a|papanicolau| 2 - "não"|
		
9. Soma do numerador 1 e 2 para gerar o numerador final

10. Cálculo da proporção entre o numerador e o denominador, multiplicado por 100 e arredondado para obtenção do resultado do problema


