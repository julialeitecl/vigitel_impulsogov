library(tidyverse)
library(survey)
library(readxl)

data <- readxl::read_excel("C:/Users/NOVO/Desktop/impulsogov/Vigitel-2023-peso-rake-new.xlsx")

# Definição do desenho amostral
dados_com_peso <- survey::svydesign(ids=~1, strata = NULL, weights = ~pesorake, data = data)

# DENOMINADOR: TOTAL DE MULHERES SEM PLANO DE SAÚDE
total_denominador <- svytotal(~q7, subset(dados_com_peso, 
                                             q7 == 2 & #mulheres
                                             q88 == 3), #sem plano 
                               na.rm = TRUE) #limpeza de NA's


# NUMERADOR (1): TOTAL DE MULHERES SEM PLANO DE SAÚDE SEM EXAME EM MAIS DE 3 ANOS
total_numerador1 <- svytotal(~q7, subset(dados_com_peso, 
                                            q7 == 2 & #mulheres
                                            q88 == 3 & #sem plano
                                            q79a == 1 & #com papanicolau
                                            q80 %in% c(4,5)), # >3 anos  
                                na.rm = TRUE) #limpeza de NA's


# NUMERADOR (2): TOTAL DE MULHERES SEM PLANO DE SAÚDE SEM EXAME NUNCA
total_numerador2 <- svytotal(~q7, subset(dados_com_peso, 
                                            q7 == 2 & #mulheres
                                            q88 == 3 & #sem plano
                                            q79a == 2), #sem papanicolau
                               na.rm = TRUE) #limpeza de NA's

# NUMERADOR
total_numerador <- total_numerador1 + total_numerador2

# PROPORÇÃO
resultado <- round((total_numerador/total_denominador)*100, 2)
print(resultado)