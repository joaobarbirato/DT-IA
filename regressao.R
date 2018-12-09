# regressao.R
# @Autores:
#   - Cassiano Maia                         726507
#   - João Gabriel Melo Barbirato           726546
#
# @Objetivo:
#   Criar uma árvore de regressão
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
    # TODO: definir o conjunto de dados
    dados <- read.table(
        '', 
        header=TRUE, 
        sep=',',
        fileEncoding="UTF-8"
    )

    # Divisão dos dados (treino e teste)
    dados_divididos <- dados.holdout(dados)

    # Cria o modelo de árvore de decisão
    
    modelo_ad <- rpart(
        , # TODO: pôr os atributos, quando o conjunto de dados estiver definido
        data=dados_divididos$treinamento,
        method="anova", # regressão
        control = rpart.control(minsplit=1), 
        parms = list(split = "Information")
    )

    # Desenha a árvore
    plot_ad <- rpart.plot(modelo_ad, type=3)

    # Prevê os dados de teste
    y_preditos <- predict(
        modelo_ad,
        dados[107:143,],
        "vector"
    )

    # Calcula métricas
    eq <- metricas.erro_quadratico(dados_divididos$teste['D'][,], y_preditos)

    retorno <- list()
    retorno$eq <- eq
    return(retorno)
}

# Exibição dos resultados
r <- main()
cat("\n### FIM DA EXECUÇÃO\n")
cat("Erro Quadrático: ", r$eq, "\n")
