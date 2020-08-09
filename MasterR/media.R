# media.R
# calcular la media de dos números

# One Way => Crear una función que calcule la media de dos números pasados como paraḿetros
media <- function(iNum1, iNum2) {
    fResult <- ((iNum1 + iNum2) / 2)
    return (fResult)
}
iMedia <- media(8, 8)
message <- paste("La media es:", iMedia)
print(message)

# Two Way => usando la función mean()
message <- paste("La media es:", mean(8,8))
print(message)

print ('That\'s all, folks!! :)') 