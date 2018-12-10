# DT-IA

[![Rdoc](http://www.rdocumentation.org/badges/version/rpart)](http://www.rdocumentation.org/packages/rpart)

Este  trabalho consta  da  execução  dos algoritmos  de  aprendizado  supervisionado (árvore  de  decisão  e  árvore de regressão) estudados na disciplina, com o uso  de funções disponíveis em pacotes de R.

## 1. Uso
## 1.1. Conjuntos de dados

- Crie a pasta para separar conjuntos de dados e código
- Entre na pasta para baixar os conjuntos de dados, como indicam ``1.1.1`` e ``1.1.2``.

```shell
mkdir dados
cd dados
```

- Baixe os conjuntos de dados:

### 1.1.1. Classificação
```shell
wget https://archive.ics.uci.edu/ml/machine-learning-databases/00479/SomervilleHappinessSurvey2015.csv
```

### 1.1.2. Regressão
```shell
wget https://archive.ics.uci.edu/ml/machine-learning-databases/00477/Real%20estate%20valuation%20data%20set.xlsx
```
- **OBS**: é necessário convertê-lo para arquivo CSV

## Instale os pacotes R ``rpart`` e ``rpart.plot``

```shell
$ R
```
```R
> install.packages("rpart")
#(...)
> install.packages("rpart.plot")
#(...)
```

## 2. Execução
```shell
R   
```
```R
source('classificacao.R')
#(...)
source('regressao.R')
#(...)
```
