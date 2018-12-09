# classificação.R
#
# @Autores:
#   - Cassiano Maia                         726507
#   - João Gabriel Melo Barbirato           726546
#
# @Objetivo:
#   Criar uma árvore de decisão para classificação
#   
# conjunto de dados: https://archive.ics.uci.edu/ml/datasets/Somerville+Happiness+Survey
#   W.W. Koczkodaj, T. Kakiashvili, A. SzymaÅ„ska, J. Montero-Marin, R. Araya, J. Garcia-Campayo,
#     K. Rutkowski, D. StrzaÅ‚ka, How to reduce the number of rating scale items without
#     predictability loss? Scientometrics, 111(2): 581â€“593, 2017.

# Biblioteca rpart
library('rpart')
library('rpart.plot')
# Declaração de funções

## Dividir o conjunto de dados em treinamento (75%) e teste (25%)
divide_dados <- function(df) {
    dividido <- list()
    embaralhado <- sample(df)

    # 0~75% dos dados (treinamento)
    porc_75 <- (nrow(df)*75) %/% 100

    dividido$treinamento <- embaralhado[1:porc_75,] 
    dividido$teste  <- embaralhado[porc_75:nrow(df),]
    return(dividido)
}

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

main <- function() {
    ## Leitura do conjunto de dados
    dados <- read.table(
        'dados/SomervilleHappinessSurvey2015.csv', 
        header=TRUE, 
        sep=',',
        fileEncoding="UTF-8"
    )
    dados_divididos <- divide_dados(dados)

    modelo_ad <- rpart(
        D~X1 + X2 + X3 + X4 + X5 + X6,
        data=dados_divididos$treinamento,
        method="class",
        control = rpart.control(minsplit=1), 
        parms = list(split = "Information")
    )

    plot_ad <- rpart.plot(modelo_ad, type=3)

    y_preditos <- predict(modelo_ad, dados[107:143,],"class")

    precisao <- metricas.precisao(dados_divididos$teste['D'][,], y_preditos)
    acuracia <- metricas.acuracia(dados_divididos$teste['D'][,], y_preditos)

    retorno <- list()
    retorno$plot <- plot_ad
    retorno$precisao <- precisao
    retorno$acuracia <- acuracia
    return(retorno)
}

r <- main()
cat("\n### FIM DA EXECUÇÃO\n")
cat("Precisão: ", r$precisao, "\n")
cat("Acurácia: ", r$acuracia, "\n\n")
