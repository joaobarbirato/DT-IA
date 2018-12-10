# classificação.R
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

# Carregar funções
source('utils.R')

main <- function() {
    # Leitura do conjunto de dados
    dados <- read.table(
        'dados/SomervilleHappinessSurvey2015.csv', 
        header=TRUE, 
        sep=',',
        fileEncoding="UTF-8"
    )

    # Divisão dos dados (treino e teste)
    dados_divididos <- dados.holdout(dados,'classificacao','D')

    # Cria o modelo de árvore de decisão
    modelo_ad <- rpart(
        D~X1 + X2 + X3 + X4 + X5 + X6,
        data=dados_divididos$treinamento,
        method="class",
        control = rpart.control(minsplit=1), 
        parms = list(split = "Information")
    )

    # Desenha a árvore
    plot_ad <- rpart.plot(modelo_ad, type=3, roundint=FALSE)

    # Prevê os dados de teste
    y_preditos <- predict(
        modelo_ad,
        dados_divididos$teste,
        "class"
    )

    # Calcula métricas
    precisao <- metricas.precisao(dados_divididos$teste['D'][,], y_preditos)
    acuracia <- metricas.acuracia(dados_divididos$teste['D'][,], y_preditos)

    retorno <- list()
    retorno$precisao <- precisao
    retorno$acuracia <- acuracia
    return(retorno)
}

# Exibição dos resultados
r <- main()
cat("\n### FIM DA EXECUÇÃO\n")
cat("Precisão: ", r$precisao, "\n")
cat("Acurácia: ", r$acuracia, "\n\n")
