# utils.R
# @Autores:
#   - Cassiano Maia                         726507
#   - João Gabriel Melo Barbirato           726546
#
# @Objetivo:
#   Definir funções que serão utilizadas nos algoritmos

# Declaração de funções

##  dados.holdout
##  @Objetivo:
##      Dividir o conjunto de dados em treinamento (75%)
##      e teste (25%)
##  @Parâmetros:
##      - df: dataframe referente ao conjunto de daods
dados.holdout <- function(df) {
    # dados embaralhados aleatoriamente
    sdados <- sample(df)

    # porção de 75% dos dados (treinamento)
    porc_75 <- (nrow(df)*75) %/% 100
    metade_porc_75 = porc_75 %/% 2

    treinamento <- rbind(
        # Metade dos 75% da classe '1'
        sdados[sdados['D']==1,][1:metade_porc_75,],
        # Outra metade dos 75% da classe '0'
        sdados[sdados['D']==0,][1:metade_porc_75,]
    )

    # Restante dos dados embaralhados
    teste <- rbind(
        sdados[sdados['D']==1,][metade_porc_75+1:nrow(sdados[dados['D']==1,]),],
        sdados[sdados['D']==0,][metade_porc_75+1:nrow(sdados[dados['D']==0,]),]
    )

    retorno <- list()
    retorno$treinamento <- treinamento
    retorno$teste  <- teste
    return(retorno)
}

##  metricas.precisao
##  @Objetivo:
##      Calcular a precisão do classificador
##  @Parâmetros:
##      - verdadeiro: vetor de classes previamente definidas
##      - predito: vetor de classes preditas pelo classificador
metricas.precisao <- function(verdadeiro,predito) {
    TAM <- length(verdadeiro)

    tp <- 0 # TRUE POSITIVES
    fp <- 0 # FALSE POSITIVES
    for (i in 1:TAM) {
        if (verdadeiro[i] == predito[i]){
            # print("verdadeiro: ", verdadeiro[i])
            # print("predito: ", predito[i])
            if(verdadeiro[i] == 1){
                tp <- tp + 1
            }else{
                fp <- fp + 1
            }
        }
    }
    # PRECISAO <- TP / (TP + FP)
    return (tp / (tp+fp))
}

##  metricas.acuracia
##  @Objetivo:
##      Calcular a acurácia do classificador
##  @Parâmetros:
##      - verdadeiro: vetor de classes previamente definidas
##      - predito: vetor de classes preditas pelo classificador
metricas.acuracia <- function(verdadeiro,predito) {
    TAM <- length(verdadeiro)
    p <- 0 # POSITIVES
    for (i in 1:TAM) {
        if (verdadeiro[i] == predito[i]){
            if(verdadeiro[i] == 1){
                p <- p + 1
            }
        }
    }
    # ACURACIA <- (TP + FP) / TOTAL
    return (p / TAM)
}

##  metricas.precisao
##  @Objetivo:
##      Calcular o erro quadrático médio do modelo
##      de regressão
##  @Parâmetros:
##      - verdadeiro: vetor de valores previamente definidos
##      - predito: vetor de valores preditos pelo classificador
metricas.erro_quadratico <- function(verdadeiro,predito) {
    return(mean((verdadeiro - predito)^2))
}
