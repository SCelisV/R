# Bucle while - bucle_while.R
numero <- 1
while (numero < 10){
    texto <- paste('El número vale', numero) # Concatenate Strings
    print(texto)

    if (numero == 5){
        break                               # finaliza el bucle while
    }
    
    numero <- numero + 1
}

