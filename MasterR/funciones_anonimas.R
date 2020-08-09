# funciones_anonimas.R


vector06 <- c(1,10,2)
print(paste("vector06", vector06))
print(class(vector06))
print(paste("is vector:", is.vector(vector06)))

# Se crea una función anonima - "sin nombre" - cuando sólo se va a ejecutar una vez
vector07 <- sapply(vector06, function(numero) {numero + 10})

print(paste("vector07", vector07))
print(class(vector07))
print(paste("is vector:", is.vector(vector07)))
