# -*- coding: utf-8 -*-
"""read_vigitel.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1DenSp86-8XaOIVp4WqBT-34bgf9jdARr
"""

import pandas as pd

dt = pd.read_excel('/content/Vigitel-2023-peso-rake.xlsx')

colunas_interesse = ['q7','q88','q79a','q80','papa','papatres']

# Conferindo type das colunas de interesse
dt[colunas_interesse].dtypes

# Conferindo valores únicos nas colunas de interesse (q7,q88,q79a,q80,papa,papatres)
for i in colunas_interesse:
  print('Coluna:', i)
  print(' Valores únicos:', (dt[i]).unique())

# Substituindo NaN para 999 nas colunas de interesse
dt[colunas_interesse] = dt[colunas_interesse].fillna(999)

# Transformando float to int
dt[['q79a','q80','papa','papatres']] = dt[['q79a','q80','papa','papatres']].astype('int64')

# Conferindo resultado final de transformação
print(dt[colunas_interesse].dtypes)
print('\n')
for i in colunas_interesse:
  print('Coluna:', i)
  print(' Valores únicos:', (dt[i]).unique())

# Salvando em Excel para abrir no R
dt.to_excel('Vigitel-2023-peso-rake-new.xlsx', index = False)