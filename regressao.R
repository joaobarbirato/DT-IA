
erro_quadratico <- function(verdadeiro,predito) {
    return(mean((verdadeiro - predito)^2))
}
