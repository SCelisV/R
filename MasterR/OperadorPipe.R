# OperadorPipe.R

# seleccionar aleatoriamente 5 registros del dataSet coches.02 en los que mpg > 20 y ordenarlos de forma descendiente 

coches.02 <- mtcars
print(head(coches.02))

# One Way
result.01 <- arrange(sample_n(filter(coches.02,mpg>20), size=5), desc(mpg))
print(result.01)

# Two Way
# seleccionar todos los coches.02 que cumplan la condición mpg > 20
paso.01 <- filter(coches.02,mpg>20)
# seleccionar aleatoriamente 5 registros 
paso.02 <- sample_n(paso.01, size=5)
# ordenar de forma descendiente
paso.03 <- arrange(paso.02, desc(mpg))
result.02 <- paso.03
print(result.02)

# Three Way - Operador PIPE %>%
result.03 <- coches.02 %>% filter(mpg>20) %>% sample_n(size=5) %>% arrange(desc(mpg))
print(result.03)