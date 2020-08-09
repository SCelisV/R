# suma_vectores.R

vector03 <- c(1,2,3)
print(paste("vector03", vector03))
print(class(vector03))
print(paste("is vector:", is.vector(vector03)))
# cat("vector03 : ", vector03)

# Esta funcion retorna la suma del número pasado como parámetro más 10
suma <- function (numero){
    result <- numero + 10
    print(paste("result", result))
    return (result)
}

# Este nuevo vector ejecuta la función suma a cada uno de los elementos del vector03

vector04 <- sapply(vector03, suma)
print(paste("vector04", vector04))
print(class(vector04))
print(paste("is vector:", is.vector(vector04)))
# cat("vector04", vector04)


vector05 <- lapply(vector03, suma)
print(paste("vector05", vector05))
print(class(vector05))
print(paste("is list:", is.list(vector05)))
