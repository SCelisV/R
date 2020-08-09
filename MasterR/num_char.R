# num_char.R

# Verificar si el valor iValor es "numeric" ó es "character"
# two way

# iValor <- 5L
# iValor <- 5
iValor <- list(12,c(1:5))


# one way
if (is.numeric(iValor)){
    message <- paste(iValor, "es numeric")
} else if (is.character(iValor)){
    message <- paste(iValor, "es character")
} else {
    message <- paste("No es numeric ni es character")
}
print(message)

# two way

class_Valor <- class(iValor)
if (class_Valor == "numeric" ){
    message <- paste(iValor, "es un", class_Valor)
} else if (class_Valor == "character"){
    message <- paste(iValor, "es un ", class_Valor)
}else {
    message <- paste("No es ni numeric ni es character")
}
print(message)

print ('That\'s all, folks!! :)') 