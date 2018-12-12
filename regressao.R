# regressao.R
# @Autores:
#   - Cassiano Maia                         726507
#   - João Gabriel Melo Barbirato           726546
#
# @Objetivo:
#   Criar uma árvore de regressão
#   
# conjunto de dados: https://archive.ics.uci.edu/ml/datasets/Real+estate+valuation+data+set
#   Yeh, I. C., & Hsu, T. K. (2018). Building real estate valuation models with comparative 
#       approach through case-based reasoning. Applied Soft Computing, 65, 260-271.


# Biblioteca rpart
library('rpart')
library('rpart.plot')

# Carregar funções
source('utils.R')

main <- function() {
    # Leitura do conjunto de dados
    dados <- read.table(
        'dados/Real_estate_valuation_dataset.csv', 
        header=TRUE, 
        sep=',',
        fileEncoding="UTF-8"
    )

    # Removendo coluna com identificador (não ajuda na regressão)
    dados$No <- NULL

    # Divisão dos dados (treino e teste)
    dados_divididos <- dados.holdout(dados,'regressao','Y')

    # Cria o modelo de árvore de decisão
    
    modelo_ad <- rpart(
        Y~X1+X2+X3+X4+X5+X6,
        data=dados_divididos$treinamento,
        method="anova" # regressão
    )

    # Desenha a árvore
    plot_ad <- rpart.plot(modelo_ad, type=3, roundint=FALSE)

    # Prevê os dados de teste
    y_preditos <- predict(
        modelo_ad,
        dados_divididos$teste,
        "vector"
    )

    # Calcula métricas
    eq <- metricas.erro_quadratico(dados_divididos$teste['Y'][,], y_preditos)

    retorno <- list()
    retorno$eq <- eq
    return(retorno)
}

# Exibição dos resultados
r <- main()
cat("\n### FIM DA EXECUÇÃO\n")
cat("Erro Quadrático: ", r$eq, "\n")
