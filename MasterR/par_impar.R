# par_impar.R

iNum <- -20L
if (iNum%%2 == 0){
    message <- paste(iNum, "es un número Par")
    print(message)
} else {
    message <- paste(iNum, "es un número IMPar")
    print(message)
}