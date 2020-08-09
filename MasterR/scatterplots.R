# scatterplots.R => gráfico de dos variables continuas
# plot
# Diagrama de dispersion

# URL: rdocumentation.org/packages/datasets/versions/3.6.2/topics/mtcars

# Construct aesthetic mappings (aes)
# https://ggplot2.tidyverse.org/reference/aes.html

coches.01 <- mtcars
print(coches.01)

# One Way
datos.08 <- ggplot(coches.01, aes(x=mpg, y=cyl))  # mpg 	Miles/(US) gallon, cyl 	Number of cylinders 
scatt.01.coches.01 <- datos.08 + geom_point()
print(scatt.01.coches.01)

datos.09 <- ggplot(coches.01, aes(x=disp, y=mpg)) # disp - pulgadas cubicas, mpg - millas por galon
scatt.02.coches.01 <- datos.09 + geom_point()
print(scatt.02.coches.01)

# alpha, color, fill, shape, size
scatt.03.coches.01 <- datos.09 + geom_point(size=8, alpha=0.4)
print(scatt.03.coches.01)

# alpha, color, fill, shape, size
scatt.04.coches.01 <- datos.09 + geom_point(size=8, alpha=0.4, color="red")
print(scatt.04.coches.01)

# alpha, color, fill, shape, size
scatt.05.coches.01 <- datos.09 + geom_point(size=8, alpha=0.4, color="#2717c4")
print(scatt.05.coches.01)

# alpha, color, fill, shape, size 
# En este caso el tamaño de los puntos estan en función de la variable wt Weight (1000 lbs) 
scatt.06.coches.01 <- datos.09 + geom_point(aes(size=wt), alpha=0.4, color="#2717c4")
print(scatt.06.coches.01)

# alpha, color, fill, shape, size
# el color será gradiente y estará en función de la variable hp
# (Displacement (cu.in.) meaning cars cubic inches. For this reason displacement is one of the measures often used in advertising, as well as regulating, motor vehicles. It is usually expressed using the metric units of cubic centimetres (cc or cm3, equivalent to millilitres) or litres (l or L), or – particularly in the United States – cubic inches (CID, cu in, or in3).)
datos.10 <- ggplot(coches.01, aes(x=disp, y=mpg)) 
scatt.07.coches.01 <- datos.10 + geom_point(size=8, aes(color=hp)) + scale_color_gradient(low="blue", high="red") +
 labs(y = "mpg - millas por galon",
 x = "disp - pulgadas cubicas",
 title = "Dataset = color en función de hp (Potencia) - scatt.07.coches.01")
print(scatt.07.coches.01)

# Two Way
#  —> millas por galon - consumo de acuerdo a la cyl - potencia de un motor
plot (coches.01$cyl ~ coches.01$mpg)

#  disp => cu.in => Dispacement => cc
plot (coches.01$mpg ~ coches.01$disp)


# ==================================== #

# limites y dimensiones
# https://ggplot2.tidyverse.org/reference/mpg.html => documentación data.frame mpg

library(ggplot2)
datos.13 <- mpg

head(datos.13)
str(datos.13)

# displ => desplazamiento del motor en litros
# hwy => millas de autopista por galon
scatt.08 <- ggplot(datos.13, aes(x=displ, y=hwy))
scatt.08 <- scatt.08 + geom_point()
print(scatt.08)

scatt.09 <- ggplot(datos.13, aes(x=displ, y=hwy)) + geom_point()
print(scatt.09)

# limites => para recortar el gráfico => like a zoom
scatt.10 <- ggplot(datos.13, aes(x=displ, y=hwy)) + geom_point() + coord_cartesian(xlim=c(2,5), ylim=c(20,30))
print(scatt.10)

# dimensiones => para escalar el gráfico => like a escalar
scatt.11 <- ggplot(datos.13, aes(x=displ, y=hwy)) + geom_point() + coord_fixed(ratio=1/3)
print(scatt.11)

# Hacer un gráfico para analizar el volumen de las ventas vs cantidad de ventas(variables continuas)
# https://ggplot2.tidyverse.org/reference/txhousing.html?q=txhousing => información del df

datos.16 <- txhousing
scatt.12 <- ggplot(datos.16, aes(sales, volume)) + geom_point(color="blue", alpha = 0.4) + geom_smooth(color="red") +
 labs(y = "volume",
 x = "sales",
 title = "Dataset = mptxhousingg - scatt.12")
print(scatt.12)

par(mfrow=c(2,2))
plot(wt,mpg, main="Scatt of wt Weight (1000 lbs) vs mpg Miles/(US) gallon")
plot(wt,disp, main="Scatt of wt Weight (1000 lbs) vs disp Displacement (cu.in.)")
hist(wt, main="Histogram of wt Weight (1000 lbs) ")
boxplot(wt, main="Boxplot of wt Weight (1000 lbs) ")

# Para hayar los valores atipicos del boxplot podemos:
pesoMayor5000lbs <- filter(coches.01, wt > 5.0)
print(pesoMayor5000lbs)