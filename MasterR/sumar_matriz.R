# sumar_matriz.R
# sumar los elementos de una matriz

# One Way => Crear una función que sume todos los elementos de una matriz pasada como parametro
sumar_matriz <- function(matriz) {
    result <- 0
    for(i in matriz){
        result <- result + i
    }
    return(result)
}
matriz_02 <- matrix(c(1:50), nrow = 5, byrow = T)
print (matriz_02)
iSuma <- sumar_matriz(matriz_02)
message <- paste("La suma de los elementos de la matriz es:", iSuma)
print(message)

# Two Way => utilizando la función sum()
message <- paste("La suma de los elementos de la matriz es:", sum(matriz_02))
print(message)
print ('That\'s all, folks!! :)') 