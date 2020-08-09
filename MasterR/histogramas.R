# histogramas.R => gŕafico de una variable continua

# Eje x -> variable a medir
# Eje y -> frecuencia de esa medida

library(ggplot2)

pelis <- movies
print(pelis)
head(pelis)

# > is(pelis, "data.frame")
# [1] TRUE

pelis[c("title","year","length","budget","rating","votes")]

# One Way
# a +geom_histogram(binwidth = 5)x, y, alpha, color, fill, linetype, size, weight b + geom_histogram(aes(y = ..density..))

# pasamos el df pelis y le indicamos que el eje x va a ser rating
datos.07 <- ggplot(pelis, aes(x=rating)) 

# geom_histogram() => crea un histograma con una variable continua
histo.pelis <- datos.07 + geom_histogram()
print(histo.pelis)

histo.01.pelis <- datos.07 + geom_histogram(binwidth = 0.2)
print(histo.01.pelis)

histo.02.pelis <- datos.07 + geom_histogram(binwidth = 0.2, color ="orange")
print(histo.02.pelis)

histo.03.pelis <- datos.07 + geom_histogram(binwidth = 0.2, color ="orange", fill="green")
print(histo.03.pelis)

histo.04.pelis <- datos.07 + geom_histogram(binwidth = 0.2, color ="orange", fill="green", alpha=0.1)
print(histo.04.pelis)

histo.05.pelis <- datos.07 + geom_histogram(binwidth = 0.2, color ="orange", fill="green", alpha=0.1) + xlab("Rating") + ylab("Frecuencia") + ggtitle("Histograma")
print(histo.05.pelis)

# pasamos el df mpg y le indicamos que el eje x va a ser cty(millas por galón)
datos.14 <- mpg
histo.06 <- ggplot(datos.14, aes(x=cty)) + geom_histogram(fill="green", alpha=0.5, bins=30) + xlab("cty") + ylab("count") + ggtitle("Dataset = mpg")
print(histo.06)


# Two Way
print(hist(pelis$rating))

# - it doesn't work => print(hist(pelis[,5]))

# # -->  freq=1, verdadero, absoluta
hist(pelis$rating,col="red")
# # --> frecuencia relativa. feq=0, false
hist(pelis$rating,col="green", freq = F)   
hist(pelis$rating,col="blue",freq=0)

