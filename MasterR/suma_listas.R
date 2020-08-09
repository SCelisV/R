# suma_listas.R

lista2 <- list(c(1:10))
print(lista2) # 1  2  3  4  5  6  7  8  9 10

# Esta funcion retorna la suma del número pasado como parámetro más un número aleatorio generado (1 a 100)
aleatorio <- function(numero){

    numero.aleatorio <- sample(1:100,2) # 5 97
    print(numero.aleatorio)
    result <- numero + numero.aleatorio
    return (result)

}

# Esta nueva lista se crea cuando se ejecuta la función aleatorio a cada uno de los elementos de la lista2
lista3 <- lapply(lista2, aleatorio)
print(lista3) # 6  99   8 101  10 103  12 105  14 107
