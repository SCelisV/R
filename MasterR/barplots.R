# barplots.R => gráfico de una variable discreta

library(ggplot2)

# str(mpg) => muestra la estructura del dataset

# head(datos.11) => muestra las primeras líneas del dataframe

# crear un barplot con la variable discreta class

# Ctrl + Shipt + S => para ejecutarlo

# One Way

# https://ggplot2.tidyverse.org/reference/mpg.html => documentación data.frame mpg

datos.11 <- mpg

barplot.01 <- ggplot(datos.11, aes(x=class))
barplot.01 <- barplot.01 + geom_bar()
print(barplot.01)


barplot.01 <- ggplot(datos.11, aes(x=class)) + geom_bar()
print(barplot.01)


barplot.02 <- ggplot(datos.11, aes(x=class)) + geom_bar(color='red', fill='blue')
print(barplot.02)

barplot.03 <- ggplot(datos.11, aes(x=class)) + geom_bar(color='#33e32d', fill='blue')
print(barplot.03)

# drv => tipo de transmisión => el relleno del gráfico se hará en función de esta variable
# string drive type 	f, r, 4, 
# f=front wheel, rueda delantera
# r=rear wheel, rueda trasera
# 4=4 wheel, cuatro ruedas

barplot.04 <- ggplot(datos.11, aes(x=class)) + geom_bar(aes(fill=drv))
print(barplot.04)

# Crear un barplot del dataset mpg para analizar la fabricación 
# manufacturer => fabricación => el relleno del gráfico se hará en función del número de cilindros (cyl)
# > factor(datos.15$cyl)
#   [1] 4 4 4 4 6 6 6 4 4 4 4 6 6 6 6 6 6 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 4 4 6 6 6
#  [38] 4 6 6 6 6 6 6 6 6 6 6 6 6 6 6 8 8 8 8 8 6 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
#  [75] 8 8 8 6 6 6 6 8 8 6 6 8 8 8 8 8 6 6 6 6 8 8 8 8 8 4 4 4 4 4 4 4 4 4 4 4 4
# [112] 4 6 6 6 4 4 4 4 6 6 6 6 6 6 8 8 8 8 8 8 8 8 8 8 8 8 6 6 8 8 4 4 4 4 6 6 6
# [149] 6 6 6 6 6 8 6 6 6 6 8 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 6 6 6 8 4 4 4 4 6 6
# [186] 6 4 4 4 4 6 6 6 4 4 4 4 4 8 8 4 4 4 6 6 6 6 4 4 4 4 6 4 4 4 4 4 5 5 6 6 4
# [223] 4 4 4 5 5 4 4 4 4 6 6 6
# Levels: 4 5 6 8
# > 
datos.15 <- mpg
barplot.05 <- ggplot(datos.15, aes(x=manufacturer)) + geom_bar(aes(fill=factor(cyl))) + 
 labs(y = "count",
 x = "manufacturer",
 title = "Dataset = mpg - barplot.05")
print(barplot.05)



