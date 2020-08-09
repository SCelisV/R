# maximo.R

# calcular el valor mázimo de un vector utilizando if, else if, else

vVector03 <- c(3, 5, 9)
iMax <- 0

# One Way => Crear una función que calcule cual es el valor máximo utilizando if, else if, else
print(vVector03)
iMax <- 0
if ((vVector03[1] > vVector03[2]) & (vVector03[1] > vVector03[3])){
    iMax <- vVector03[1]
} else if ((vVector03[2] > vVector03[1]) & (vVector03[2] > vVector03[3])) {
    iMax <- vVector03[2]
} else {
    iMax <- vVector03[3]
}
print (iMax)


# Two Way - con if, else if, else
print(vVector03)
if ((vVector03[1] > vVector03[2]) & (vVector03[1] > vVector03[3])){
    message <- paste("El máximo es", vVector03[1])
} else if ((vVector03[2] > vVector03[1]) & (vVector03[2] > vVector03[3])) {
    message <- paste(vVector03[2], "es el máximo")
} else {
    message <- paste(vVector03[3], "es el máximo")
}
print(message)

# Three Way - con la function max()
print(vVector03)
message <- paste("El valor máximo del vector es:", max(vVector03))
print(message)

print ('That\'s all, folks!! :)') 