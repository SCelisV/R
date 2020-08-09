# ML.R
# http://archive.ics.uci.edu/ml/datasets.php => dataSets

# Machine learning => automatiza la construcción de un módelo analítico, uso de algoritmos que aprende de los datos.
# Algoritmos: Supervisado, NO Supervisado, de Refuerzo

# Supervisado => necesita datos previamente etiquetados(lo que es correcto y lo que no es correcto) para aprender a realizar el trabajo. En base a esto, el algoritmo aprenderá a resolver problemas futuros similares.
# 1. -> Regresión líneal,
# 2. -> Regresión logística
# 3. -> Máquinas de Soporte Vectorial -> SVM

# NO Supervisado => necesita indicaciones previas, No necesita datos previamente etiquetados. Aprende a comprender y a analizar la información. Práctica sobre los datos que tiene.
# 1. -> K vecinos más cercanos - KNN
# 2. -> Árboles de decisión :  https://web.fdi.ucm.es/posgrado/conferencias/JorgeMartin-slides.pdf
# 3. -> Random Forest -> Bosques Aleatorios
# 4. -> k-medias -> no supervisado, usado para clusterización

# de Refuerzo => aprende por su cuenta, en base a conocimientos introducidos previamente, aprende en función del éxito ó fracaso.

# 1. -> Regresión líneal - Supervisado - Aproximación que modela una relación entre una variable escalar dependiente ("Y") y una o más variables explicativas ("X")
# Dibujará una recta que nos indicará la tendencia del conjunto de datos, y nos ayudará a predecir en función de un valor X un valor Y.

# http://archive.ics.uci.edu/ml/datasets/Student+Performance => Student Performance => hadoop@ubuntu-hokkaido-3568:~/R/Data/workSpace/MasterR$

datos.18 <- read.csv('student-mat.csv', sep=";")
datos.18
# names(datos.18) # con esto vemos los nombres de las variables
# summary(datos.18)
# str(datos.18)
# 'data.frame':   395 obs. of  33 variables:
# head(datos.18)
# length ( datos.18 )
# [1] 33
# n = length ( datos.18 [[1]])
# n
# [1] 395

# Estimar el valor de la variable " G3 -> final grade (numeric: from 0 to 20, output target) ",  en función de ToDos los valores del dataset ( G3 ~ .)

# limpieza de datos
# verificar los null's
NULOS <- any(is.na(datos.18))
print (NULOS)

# si NULOS => FALSE => NO hay null's

library(ggplot2)
# library(ggthemes)
# library(dplyr)

help(lm)

# para saber si una columna de un set de datos es numerica
# is.numeric(datos.18$age)
# [1] TRUE

# crear un df con las columnas que son numericas en el dataSet
columnas.numericas <- sapply(datos.18, is.numeric)

# calculamos el coeficiente de CORrelación
# NO Diagonales => Correlación —> entran escalados entre -1 y 1.
# Si las variables están muy correlacionadas R tendrá valor entre -1 y 1.
# Existen dos tipos de correlaciones tanto negativas como positivas
# Correlación positiva => > 0 , aumenta una variable por tanto aumenta la otra.
# ex: Estatura - Peso - crecen a la vez.
# Correlación negativa => < 0, aumenta una variable y disminuye la otra.
# ex: Velocidad vs Autonomía. > aceleración < autonomía

# Cuando están más cercanos a 1, la nube de puntos va a ser más perfecta a una línea.
# si hay alguna correlación que me dé 1.00000000 podemos decir que es una
# correlación perfecta., ó que esas dos variables son la misma variable, independiente de las
# unidades en que este medida.
# correlación baja está entre -0,2 y +0,2
# Valores altos => cercano a -1 ó +1 —> en la primera fila y primera columna.
# Valores bajos => cercanos a 0 => resto de elementos entre la segunda fila y la diagonal.
# R: = 0 => Indica que no tienen nada de correlación.
# R: = 1 => Correlación Perfecta.

coef.correlacion <- round(cor(datos.18[,columnas.numericas]),2)
print(coef.correlacion)
hist(datos.18$G3)

# calculamos la matriz de VARianzas - En este caso no es necesario

# Diagonales => Varianza
# NO Diagonales => COVarianza

mat.varianzas <- round(var(datos.18[,columnas.numericas]),2)
print(mat.varianzas)

# Gráfico de correlación múltiple = Cuanto más definida está el gráfico hay más correlación
cor_multiple <- pairs(datos.18[,columnas.numericas])
print(cor_multiple)


# install.packages("corrgram")
# install.packages("corrplot")

library(corrgram)
library(corrplot)

# Gráfico de correlación, en este caso las variables no numericas, las más correlacionadas son G1 vs G2 y G3 vs G2
cor.01 <- corrplot(coef.correlacion) # los pinta con circulos
cor.01 <- corrplot(coef.correlacion, method='color') # los pinta con cuadrados

pairs (datos.18[,31:33]) # vemos que la nube de puntos está muy definida

plot(datos.18$G3 ~ datos.18$G2, pch=19) # creamos la nube de puntos de las variables más correlacionadas (variable de estudio ~ variable dependiente)
plot(datos.18$G3 ~ datos.18$G1, pch=19) # creamos la nube de puntos de las variables más correlacionadas

# Gráfico de correlación, con todas las variables
cor.02 <- corrgram(datos.18)

# Cargar una función en memoria:
source('myImagePlot.R')
# Ejecuto la función:
myImagePlot(cor(datos.18[,columnas.numericas]))

correlacion<-round(cor(datos.18[,columnas.numericas]), 1)
corrplot(correlacion, method="number", type="upper")


# Creamos un histograma de la variable que queremos observar
histo.07 <- ggplot(datos.18, aes(x=G3)) + geom_histogram(bins=20)
histo.07 <- ggplot(datos.18, aes(x=G3)) + geom_histogram(bins=20, alpha=0.5, fill="blue")
print(histo.07)

# -O-J-O- Aunque parecen iguales histo.07 es diferente a histo.08
histo.08 <- hist(datos.18$G3, bins=20)
print(histo.08)

install.packages("caTools")
library(caTools)

# En estos modelos en los que tenemos muchas variables cualitativas, no se puede dibujar todas las variables.
# Lo que se suele hacer es dividir la muestra en dos partes, training(entrenamiento) y test.
# Para que un mismo código se ejecute siempre igual utilizando números aleatorios es
# utilizando la misma semilla: "seed" - vamos a tener un número aleatorio que será el mismo para todos.

# Dividimos la muestra en training y test
set.seed(80)
# Crea una variable de tal manera que de todos los datos de la columna G3 selecciona aleatoriamente el 70% y la marca como "TRUE" y el otro 30% lo marca como "FALSE"
sample.01 <- sample.split(datos.18$G3, SplitRatio = 0.7)
# train.01 => Creamos los datos que tienen TRUE para entrenamiento
train.01 <- subset(datos.18, sample.01 == TRUE)
# test.01 => Creamos los datos que tienen FALSE para test
test.01 <- subset(datos.18, sample.01 == FALSE)

# construimos el modelo de regresión lineal
# G3~. => Columna (G3) de la que se va a hacer la estimación vs (.) Todas las columnas del dataSet
# G3~Algunas variables  => Columna (G3) de la que se va a hacer la estimación vs (Algunas variables) que queremos realizar la estimación
lm.01 <- lm(G3~. , train.01)
print(summary(lm.01)) # para revisar el modelo que hemos creado:

# R makes it easy to combine multiple plots into one overall graph, using either the
# par( ) or layout( ) function.

# With the par( ) function, you can include the option mfrow=c(nrows, ncols) to create a matrix of nrows x ncols plots that are filled in by row. mfcol=c(nrows, ncols) fills in the matrix by columns.

#Diagnosis
par(mfrow = c(2,2))
plot(lm.01, pch=19)

par(mfrow = c(1,1))
plot(residuals(lm.01) ~ fitted(lm.01), cex =3)
abline(c(0,0), lwd =3, col="red")

# summary(lm.01)

# Call:
# lm(formula = G3 ~ ., data = train.01) # con los datos de entrenamiento

# Residuals: # Diferencia entre los puntos actuales de las notas y la línea de regresión(las predicciones)
#     Min      1Q  Median      3Q     Max
# -7.6187 -0.5742  0.2859  0.9561  4.6622

# Coefficients:
#                   Estimate Std. Error t value Pr(>|t|)
# (Intercept)      -0.604593   2.585771  -0.234 0.815332
# schoolMS          0.508004   0.432127   1.176 0.240949
# sexM              0.084558   0.284179   0.298 0.766309
# age              -0.221760   0.125624  -1.765 0.078818 .
# addressU          0.300208   0.328761   0.913 0.362099
# famsizeLE3        0.013510   0.269399   0.050 0.960047
# PstatusT         -0.176428   0.396888  -0.445 0.657070
# Medu              0.161011   0.175585   0.917 0.360083
# Fedu             -0.056375   0.158238  -0.356 0.721960
# Mjobhealth        0.069912   0.622606   0.112 0.910690
# Mjobother         0.274769   0.382898   0.718 0.473714
# Mjobservices     -0.039659   0.439512  -0.090 0.928177
# Mjobteacher       0.397866   0.582322   0.683 0.495128
# Fjobhealth        0.404921   0.765907   0.529 0.597525
# Fjobother         0.014856   0.538507   0.028 0.978014
# Fjobservices     -0.245058   0.576221  -0.425 0.671018
# Fjobteacher      -0.426524   0.715837  -0.596 0.551856
# reasonhome       -0.258794   0.314191  -0.824 0.410955
# reasonother       0.184480   0.458785   0.402 0.687971
# reasonreputation  0.049474   0.313758   0.158 0.874842
# guardianmother    0.137886   0.312144   0.442 0.659085
# guardianother     0.186926   0.551567   0.339 0.734988
# traveltime        0.312642   0.182022   1.718 0.087186 .
# studytime         0.002298   0.165039   0.014 0.988903
# failures         -0.191750   0.185512  -1.034 0.302374
# schoolsupyes      0.328873   0.384740   0.855 0.393536
# famsupyes         0.287557   0.273198   1.053 0.293624
# paidyes          -0.045122   0.275074  -0.164 0.869844
# activitiesyes    -0.364792   0.244613  -1.491 0.137223
# nurseryyes       -0.495734   0.300716  -1.649 0.100584
# higheryes         0.198312   0.595546   0.333 0.739438
# internetyes      -0.211749   0.344051  -0.615 0.538849
# romanticyes      -0.570600   0.257288  -2.218 0.027529 *
# famrel            0.334560   0.143161   2.337 0.020283 *
# freetime         -0.036975   0.135855  -0.272 0.785735
# goout             0.075163   0.121018   0.621 0.535143
# Dalc             -0.172839   0.182867  -0.945 0.345547
# Walc              0.192967   0.135481   1.424 0.155683
# health            0.071997   0.090268   0.798 0.425916
# absences          0.070349   0.019353   3.635 0.000341 ***
# G1                0.119215   0.076776   1.553 0.121826
# G2                1.007317   0.066454  15.158  < 2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Residual standard error: 1.879 on 235 degrees of freedom
# Multiple R-squared:  0.8585,    Adjusted R-squared:  0.8338
# F-statistic: 34.78 on 41 and 235 DF,  p-value: < 2.2e-16


# B0 -> Estimate -> 0.604593,
# Con el aumento de una unidad del regresor (age, traveltime , romanticyes, famrel, absences, G2), en promedio la variable de respuesta (G3) aumenta en un (-0.221760, 0.312642,-0.570600, 0.334560, 0.070349, 1.007317), respectivamente.
#                   Estimate Std. Error t value Pr(>|t|)
# (Intercept)      -0.604593   2.585771  -0.234 0.815332


# Signif. codes: uno ó mas asteriscos quiere decir que con un 95% de confianza puedo afirmar que el regresor es significativo,
# El p-value va a estar por debajo de 0.05.

# Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 => Indica si el regresor influye ó no.

# age              -0.221760   0.125624  -1.765 0.078818 .
# traveltime        0.312642   0.182022   1.718 0.087186 .
# romanticyes      -0.570600   0.257288  -2.218 0.027529 *
# famrel            0.334560   0.143161   2.337 0.020283 *
# absences          0.070349   0.019353   3.635 0.000341 ***
# G2                1.007317   0.066454  15.158  < 2e-16 ***


# Desviación típica = 2.585771 = Std. Error -> Precisión con la que se ha calculado

# (age, -0.221760, traveltime, 0.312642, romanticyes, -0.570600, famrel, 0.334560, absences, 0.070349, G2, 1.007317)


# Residual standard error: Desviación Típica Residual: 1.879 on 235 degrees of freedom => Importante con 95% de confianza puedo afirmar ...  (G3 -> final grade) ..??

# R-squared: Coeficiente de Determinación - R^2 - cuadrado - R-squared: Me sirve para predecir "con mucha precisión”, cuál va a ser el error del modelo, R² cuantifica la proporción como un porcentaje.

# Multiple R-squared:  0.8585 => Cómo de bueno es el modelo de regresión. Coeficiente de Desviación. 0 <= R^2 <=1.
# Somos capaces de explicar el 85% de la variación de G3


# - Cual es la probabilidad de un evento mas desfavorable.
# p-value -> indica si el regresor influye ó no influye en la variable de respuesta.
# p-value: < 2.2e-16 si < 0.05 => indica si el regresor influye , es decir, influye con un 95%.
# Si p-value: < 0.05 Influye
# Si p-value > 0.05 No tenemos evidencia para decir que influye significativamente.

# Estoy muy segur@ de estos valores (age, -0.221760, traveltime, 0.312642, romanticyes, -0.570600, famrel, 0.334560, absences, 0.070349, G2, 1.007317)


# confint(lm.01) -> # Intervalo de Confianza para los B0 y B1 poblacionales.

# Con un 95% de Intervalo de confianza puedo decir que el B1
# Poblacional de cada uno de los regresores va a estar entre:

# age              -0.46925288  0.02573386
# traveltime       -0.04596167  0.67124665
# romanticyes      -1.07748616 -0.06371407
# famrel            0.05251738  0.61660244
# absences          0.03222188  0.10847554
# G2                0.87639510  1.13823918

# Para comprobar el modelo, calculamos los residuos (diferencia entre el valor real y el estimado)
residuos <- residuals(lm.01)
class(residuos)

residuos <- as.data.frame(residuos)
class (residuos)

head(residuos)

ggplot(residuos, aes(residuos)) + geom_histogram(fill='blue', alpha=0.5)

# la mayor parte de los valores esta concentrado en el 0.0 (valor ideal, sin discrepancia entre el valor estimado y el valor real, el modelo se ajusta para calcular las estimaciones de G3)

# Una recta de regresión debe cumplir:
# Que la distancia entre los puntos a la recta de regresión sea mínima.

# Hipótesis de Partida - Diagnosis
# - Linealidad -> Se DA por supuesta - Las variables siguen una relación lineal.
# - Normalidad -> Se debe comprobar que los residuos siguen una distribución normal
#     La Y para TODAS las X NO sigue una distribución normal.. PERO
#     La variable Y para un determinado valor de X SI sigue una distribución normal.
# - Homocedasticidad -> varianza constante ó variabilidad constante - distribución de probabilidad de idéntica amplitud para cada variable aleatoria -
    # La nube de puntos tenga un grosor constante.
    # Heterocedastico -> varianza NO es constante ó variabilidad NO constante, a pesar de que la nube de puntos tiene forma lineal la varianza ó dispersión va aumentando:
# - Independencia -> Cuando las observaciones en sí no están relacionadas.


# https://rpubs.com/camilamila/correlaciones

#Cargar paquetes
# install.packages("readxl")
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("GGally")
# install.packages("Hmisc")
# install.packages("corrplot")
# install.packages("PerformanceAnalytics")

#Cargar paquetes
library(readxl)
library(dplyr)
library(ggplot2)
library(GGally)
library(Hmisc)
library(corrplot)
library(PerformanceAnalytics)

correlacion<-round(cor(datos.18[,columnas.numericas]), 1)
corrplot(correlacion, method="number", type="upper")

# Calcula el pvalor para los datos y lo muestra como una matriz
    # Este comando nos da la misma matriz de correlación y además nos da el p-value.
    # En todos el casos el p-value es muy bajo
pvalue <-
rcorr(as.matrix(datos.18[,columnas.numericas]))
print (pvalue)

# p-value -> indica si el regresor influye ó no influye en la variable de respuesta.
# Si p-value: < 0.05 Influye con un 95% de confianza
# Si p-value > 0.05 No tenemos evidencia para decir que influye significativamente.

# También podemos hacer gráficos de dispersión, calcular los coeficientes de una sola vez y ver si son estadísticamente significativos, con un solo comando:
chart.Correlation(datos.18[,columnas.numericas], histogram = F, pch = 19)


# ===

predicciones <- predict(lm.01, test.01)
result <- cbind(predicciones, test.01$G3)
head(result)
colnames(result) <- c('prediccion', 'real')
head(result)
class (result)
# [1] "matrix"
result <- as.data.frame(result)
class (result)
# [1] "data.frame"

result$prediccion
#   [1]  4.3771174 15.6568779 12.7715234 16.3655279  8.9631854 16.3820285
#   [7]  9.1435439 13.1077328  9.1062061 13.4271280 15.3995283 16.1977627
#  [13] 17.4702455 14.3544266  5.5530143 15.6970621  9.6885738  7.6024850
#  [19]  6.4328098  7.4915172 17.4899080 12.3218790  7.5560755  6.2443488
#  [25] 11.5012159 10.3432983 12.1191638 15.3745353 12.5415249 13.4109435
#  [31]  0.6146943 12.4557150  0.4853426 16.1308560  9.6426976 13.0082216
#  [37] 11.8844407 16.5595060  8.9278011 10.7956852  8.2745915 13.9869789
#  [43]  3.8424954 10.2342860  8.8699591  9.2970282 17.3334563 11.5048783
#  [49]  7.5513623 14.1430590  9.0588090 10.3726738  6.3582595 11.5719115
#  [55] 13.3199785 10.5074965 15.4200688  5.0613810  7.7257296  9.0689039
#  [61]  9.4408250  9.5712700  7.3036283  9.8130347 10.9934444 10.4573352
#  [67] -1.4233843 19.4598327  6.0324620  3.4604733  5.7240723 11.1522398
#  [73] 11.8401552 12.0369193 14.5013825  7.0452523  8.3336442 17.6024005
#  [79]  8.8341655 10.3233054  9.0050324  8.4608129 19.9131016 13.5218370
#  [85]  7.0954642 13.9010138 18.0228677 13.6203431 11.7089381 11.3337263
#  [91] 10.4307172 10.6882871  8.3023398 14.7470793  8.8220641  5.4362661
#  [97]  9.9246858  8.7264188  8.2918289 13.5295694 13.7973234  8.0457389
# [103] 11.7479906 14.1316461 14.7237754 10.0418208  7.2525971 11.0112219
# [109] 12.6943915 10.8127159 11.6031553  6.1181639  5.3383231 10.4908875
# [115]  8.3727427  2.9183605 16.0769137 13.0006790
result$real
#   [1]  6 15 11 15 12 18 11 10 11 13 15 15 16 11  6 15 10  8  6  7 18 14 10  6 11
#  [26] 13 13 16 14 13  0 12  0 15 11 14 13 15  7 12 10 16  0  9  9 11 17 11  8 14
#  [51] 11 10  8 13 14 10 15  8  7  9 12  9  6 10 12 12  0 18  8  5  8 10 12 11 14
#  [76]  9  0 17  9 10  8 10 19 14  8 16 18 13 12 10 11 11  9 15  9  0 10  0  0 14
# [101] 13  8 11 13 15 10  0 10 12 11 10  0  5 10  8  0 16 10
min(result$prediccion)
# [1] -1.423384

min(result)
# [1] -1.423384 => teniendo en cuenta que la nota mínima es cero =>
# creamos una función que reemplace los valores negativos del dataSet por 0

cero <- function(x) {
    if (x<0)
        {return (0)}
    else
        {return (x)}
}

result$prediccion <- sapply(result$prediccion, cero) # aplicando, ejecutando la funcion cero sobre la columna predicción

result$prediccion
#   [1]  4.3771174 15.6568779 12.7715234 16.3655279  8.9631854 16.3820285
#   [7]  9.1435439 13.1077328  9.1062061 13.4271280 15.3995283 16.1977627
#  [13] 17.4702455 14.3544266  5.5530143 15.6970621  9.6885738  7.6024850
#  [19]  6.4328098  7.4915172 17.4899080 12.3218790  7.5560755  6.2443488
#  [25] 11.5012159 10.3432983 12.1191638 15.3745353 12.5415249 13.4109435
#  [31]  0.6146943 12.4557150  0.4853426 16.1308560  9.6426976 13.0082216
#  [37] 11.8844407 16.5595060  8.9278011 10.7956852  8.2745915 13.9869789
#  [43]  3.8424954 10.2342860  8.8699591  9.2970282 17.3334563 11.5048783
#  [49]  7.5513623 14.1430590  9.0588090 10.3726738  6.3582595 11.5719115
#  [55] 13.3199785 10.5074965 15.4200688  5.0613810  7.7257296  9.0689039
#  [61]  9.4408250  9.5712700  7.3036283  9.8130347 10.9934444 10.4573352
#  [67]  0.0000000 19.4598327  6.0324620  3.4604733  5.7240723 11.1522398
#  [73] 11.8401552 12.0369193 14.5013825  7.0452523  8.3336442 17.6024005
#  [79]  8.8341655 10.3233054  9.0050324  8.4608129 19.9131016 13.5218370
#  [85]  7.0954642 13.9010138 18.0228677 13.6203431 11.7089381 11.3337263
#  [91] 10.4307172 10.6882871  8.3023398 14.7470793  8.8220641  5.4362661
#  [97]  9.9246858  8.7264188  8.2918289 13.5295694 13.7973234  8.0457389
# [103] 11.7479906 14.1316461 14.7237754 10.0418208  7.2525971 11.0112219
# [109] 12.6943915 10.8127159 11.6031553  6.1181639  5.3383231 10.4908875
# [115]  8.3727427  2.9183605 16.0769137 13.0006790

min(result$prediccion)
# [1] 0


# Hay varias formas de hacer la Evaluación del modelo:

# ME - Mean Error
# RMSE - Root Mean Square Error
# MAE - Mean Absolute Error
# MPE - Mean Percentage Error
# MASE - Mean Absolute Scaled Error
# MAPE - Mean Absolute Percentage Error = mean ( abs ( predicción - real / real ) )
# MSE - Mean of Square Error => mean ( ( predicción - real ) ^ 2 )
# SST - Sum of Square Total =>  es la diferencia al cuadrado entre la variable dependiente observada y su valor medio (media) => SST = Σ(actual-mean)²
# SSR - Sum of Squared Regression => La suma de las diferencias entre predicción y la media de la variable dependiente => Σ(predicción-mean)²
# SSE - Sum of Square Error => sum ( ( predicción - real ) ^ 2 ) => es la diferencia entre el valor observado y el valor de la predicción => SSE = Σ(real-predicción)²



# MSE - Mean of Square Error => mean ( ( predicción - real ) ^ 2 )
mse.01 <- mean( (result$real - result$prediccion)^2)
print(mse.01)

# SSE - Sum of Square Error => sum ( ( predicción - real ) ^ 2 ) => es la diferencia entre el valor observado y el valor de la predicción => SSE = Σ(real-predicción)²
sse.01 <- sum ( ( result$prediccion - result$real ) ^ 2 )
print(sse.01)

# TSS ó SST - Total Sum Square => la suma de todas las diferencias cuadradas entre la media de las observaciones y su conjunto
sst.01 <-  sum ( ( mean(datos.18$G3) - result$real ) ^ 2 )
print(sst.01)

ssr.01 <- sum ( ( result$prediccion - mean(datos.18$G3) ) ^ 2 )
print(ssr.01)

# R² = 1-(SSE/SST)
rSquare.01 <- 1 - ( sse.01 / sst.01 )
print(rSquare.01)

# R² = SSR/SST
rSquare01.01 <- ( ssr.01 / sst.01 )
print(rSquare01.01)

# R-squared: # Somos capaces de explicar el 77% de la variación de G3.

# 2. -> Regresión logística - Supervisado - Predecir el resultado de una variable categorica en función de otras independientes.
# Modela la probabilidad de que un evento ocurra en función de otros factores, método de clasificación (binaria, 1 ó 0).
# Dibujará una curva que nos indicará la tendencia del conjunto de datos, y nos ayudará a predecir en función de un valor X un valor Y.
# Siempre será entre 0 ó 1

# Si resultado >= 0.5 => devuelve 1
# Si resultado < 0.5 => devuelve 0


# Matriz de Confusión => Compara el valor real con el valor de prediccion

# Real vs predicción

# SI vs SI => PC => Positivo Correcto
# NO vs NO => NC => Negativo Correcto
# SI vs NO => FP => Falsos Positivos => Error Tipo 1
# NO vs SI => FN => Falsos Negativos => Error Tipo 2

# La precisión sirve para saber la probabilidad de acierto en la predicción => (PC + NC ) / Total
# La tasa de error sirve para saber la probabilidad de error en la predicción => (FP + FN) / Total

# API Command => kaggle kernels pull alexisbcook/titanic-tutorial


datos.19 <- read.csv('titanic.csv')
datos.19
# names(datos.19) # con esto vemos los nombres de las variables
# summary(datos.19)
# str(datos.19)
# 'data.frame':   891 obs. of  12 variables:
# head(datos.19)
# length ( datos.19 )
# [1] 12
# n = length ( datos.19 [[1]])
# n

library(ggplot2)
help(glm)

ggplot(datos.19, aes(Survived)) + geom_bar()
ggplot(datos.19, aes(Pclass)) + geom_bar(aes(fill=factor(Pclass)))

ggplot(datos.19, aes(Survived,Pclass)) + geom_jitter(aes(color=factor(Pclass)))

ggplot(datos.19, aes(Age)) + geom_histogram(bins=20, alpha=0.5,fill='green')

ggplot(datos.19, aes(Survived,Pclass,Sex)) + geom_jitter(aes(color=factor(Sex)))

ggplot(datos.19, aes(Survived,Pclass,Sex)) + geom_jitter(aes(group=Sex, color=factor(Sex), alpha=0.0))

ggplot(datos.19, aes(Pclass, Age)) + geom_boxplot(aes(group=Pclass, fill=factor(Pclass), alpha=0.0))

ggplot(datos.19, aes(Survived,Pclass,Sex,Age)) + geom_jitter(aes(group=Sex, color=factor(Age), alpha=0.5))

# limpieza de datos
install.packages('Amelia')
library(Amelia)

# Crea un gráfico que nos permite Verificar si hay nulls en cada una de las columnas
missmap(datos.19, main="Verifica nulls", col=c('red', 'black')) # red => si hay nulls y black NO hay nulls

# Comprobación de que no se puede calcular la media de edad.
round(mean(datos.19$Age),0) # [1] NA

# Para limpiar estos datos lo que haremos será sustituir los valores NA de las edades por la media de edad en cada Pclass

# One Way
# creamos una función que reemplace los valores nulls del dataSet por 0, le pasamos la columna edad, y la columna clase
datos.19$Age
nulos <- function(Age, Pclass) {
    newAge <- Age
    for(i in 1:length(Age)){
        if( is.na(Age[i]) ) { # si es null
            if(Pclass[i] == 1){
                newAge[i] <- 33.00
            } else if(Pclass[i] == 2){
                newAge[i] <- 28.00
            } else if(Pclass[i] == 3){
                newAge[i] <- 18.00
            }   
        }        
    }
    return(newAge)
}

# Funciones con varios argumentos y aplicar el resultado a una columna
datos.19$Age <- nulos(datos.19$Age, datos.19$Pclass)


# Two Way
# creamos una función que reemplace los valores nulls del dataSet por 0, para poder calcular la media

factor(datos.19$Pclass)

nulos <- function(x) {
    #print(x)
    if( is.na(x) )
        {return (0)}
    else
        {return (x)}
}

# ejecutar la función para probarla
nulos(NA)
nulos(38)

# crear subset de datos por cada clase
datos19.Pclass1 <- subset(datos.19, datos.19$Pclass == 1)
datos19.Pclass2 <- subset(datos.19, datos.19$Pclass == 2)
datos19.Pclass3 <- subset(datos.19, datos.19$Pclass == 3)
# reemplazar los valores NA por 0 con la función
datos19.Pclass1$Age <- sapply(datos19.Pclass1$Age, nulos)
datos19.Pclass2$Age <- sapply(datos19.Pclass2$Age, nulos)
datos19.Pclass3$Age <- sapply(datos19.Pclass3$Age, nulos)
# calcular la media
round(mean(datos19.Pclass1$Age),0) # [1] 33
round(mean(datos19.Pclass2$Age),0) # [1] 28
round(mean(datos19.Pclass3$Age),0) # [1] 18

# Three Way - Otra forma de codificar la función..
# creamos una función que reciba la edad y la clase, reemplaza los valores nulls del dataSet por la media que corresponda con la clase:
nulos <- function(x, y) {
    # x => edad => datos.19$Age
    # y => class => datos.19$Pclass
    print(x)
    print(y)
    if (y == 1){
        if( is.na(x) )
            {return (33)}
        else
            {return (x)}
    } else if (y == 2) {
            if( is.na(x) )
                {return (28)}
            else
                {return (x)}
    } else if (y == 3) {
            if( is.na(x) )
                {return (18)}
            else
                {return (x)}
    }
    else {return (x)}
}

nulos (NA, 1)
nulos (NA, 2)
nulos (NA, 3)
nulos (38, 1)
nulos (38, 2)
nulos (38, 3)
nulos (NA, 4)
nulos (NA, 5)
nulos (NA, 6)
nulos (38.00, 4)
nulos (35.00, 5)
nulos (54.00, 6)
nulos (38.00, 3)
nulos (35.00, 1)
nulos (54.00, 3)

# Ejecutar el modelo
library(dplyr)

# Eliminamos del df columnas que no necesitamos...como: (PassengerId, Name, Ticket, Cabin)

str(datos.19)
# 'data.frame':   891 obs. of  12 variables:
#  $ PassengerId: int  1 2 3 4 5 6 7 8 9 10 ...
#  $ Survived   : int  0 1 1 1 0 0 0 0 1 1 ...
#  $ Pclass     : int  3 1 3 1 3 3 1 3 3 2 ...
#  $ Name       : Factor w/ 891 levels "Abbing, Mr. Anthony",..: 109 191 358 277 16 559 520 629 417 581 ...
#  $ Sex        : Factor w/ 2 levels "female","male": 2 1 1 1 2 2 2 2 1 1 ...
#  $ Age        : num  22 38 26 35 35 18 54 2 27 14 ...
#  $ SibSp      : int  1 1 0 1 0 0 0 3 0 1 ...
#  $ Parch      : int  0 0 0 0 0 0 0 1 2 0 ...
#  $ Ticket     : Factor w/ 681 levels "110152","110413",..: 524 597 670 50 473 276 86 396 345 133 ...
#  $ Fare       : num  7.25 71.28 7.92 53.1 8.05 ...
#  $ Cabin      : Factor w/ 148 levels "","A10","A14",..: 1 83 1 57 1 1 131 1 1 1 ...
#  $ Embarked   : Factor w/ 4 levels "","C","Q","S": 4 2 4 4 4 3 4 4 4 2 ...

datos.20 <- select(datos.19, -PassengerId, -Name, -Ticket, -Cabin)
print(datos.20)
str(datos.20)
# 'data.frame':   891 obs. of  8 variables:
#  $ Survived: int  0 1 1 1 0 0 0 0 1 1 ...
#  $ Pclass  : int  3 1 3 1 3 3 1 3 3 2 ...
#  $ Sex     : Factor w/ 2 levels "female","male": 2 1 1 1 2 2 2 2 1 1 ...
#  $ Age     : num  22 38 26 35 35 18 54 2 27 14 ...
#  $ SibSp   : int  1 1 0 1 0 0 0 3 0 1 ...
#  $ Parch   : int  0 0 0 0 0 0 0 1 2 0 ...
#  $ Fare    : num  7.25 71.28 7.92 53.1 8.05 ...
#  $ Embarked: Factor w/ 4 levels "","C","Q","S": 4 2 4 4 4 3 4 4 4 2 ...
> # factorizar ó categorizar con valores concretos:

datos.20$Survived <- factor(datos.20$Survived)
datos.20$Survived

datos.20$Pclass <- factor(datos.20$Pclass)
datos.20$Pclass

datos.20$Parch <- factor(datos.20$Parch)
datos.20$Parch

datos.20$SibSp <- factor(datos.20$SibSp)
datos.20$SibSp

str(datos.20)
# 'data.frame':   891 obs. of  8 variables:
#  $ Survived: Factor w/ 2 levels "0","1": 1 2 2 2 1 1 1 1 2 2 ...
#  $ Pclass  : Factor w/ 3 levels "1","2","3": 3 1 3 1 3 3 1 3 3 2 ...
#  $ Sex     : Factor w/ 2 levels "female","male": 2 1 1 1 2 2 2 2 1 1 ...
#  $ Age     : num  22 38 26 35 35 18 54 2 27 14 ...
#  $ SibSp   : Factor w/ 7 levels "0","1","2","3",..: 2 2 1 2 1 1 1 4 1 2 ...
#  $ Parch   : Factor w/ 7 levels "0","1","2","3",..: 1 1 1 1 1 1 1 2 3 1 ...
#  $ Fare    : num  7.25 71.28 7.92 53.1 8.05 ...
#  $ Embarked: Factor w/ 4 levels "","C","Q","S": 4 2 4 4 4 3 4 4 4 2 ...

# Crear predicciones sobre la columna Survived por lo tanto vamos a dividir los datos en training y test:
library(caTools)
set.seed(90)

# Crea una variable de tal manera que de todos los datos de la columna Survived selecciona aleatoriamente el 70% y la marca como "TRUE" y el otro 30% lo marca como "FALSE"
sample.02 <- sample.split(datos.20$Survived, SplitRatio = 0.7)
# train.02 => Creamos los datos que tienen TRUE para entrenamiento
train.02 <- subset(datos.20, sample.02 == TRUE)
# test.02 => Creamos los datos que tienen FALSE para test
test.02 <- subset(datos.20, sample.02 == FALSE)

str(train.02)
str(test.02)

# Entrenar el modelo para predecir la variable de sobrevivencia Survived
glm.01 <- glm(Survived~., family=binomial(link='logit') , data=train.02)
summary (glm.01)

# Call:
# glm(formula = Survived ~ ., family = binomial(link = "logit"), 
#     data = train.02)

# Deviance Residuals: 
#     Min       1Q   Median       3Q      Max  
# -2.8567  -0.6151  -0.3837   0.5783   2.5328  

# Coefficients:
#               Estimate Std. Error z value Pr(>|z|)    
# (Intercept)  1.974e+01  3.956e+03   0.005 0.996018    
# Pclass2     -1.024e+00  3.624e-01  -2.827 0.004701 ** 
# Pclass3     -2.398e+00  3.780e-01  -6.345 2.22e-10 ***
# Sexmale     -2.603e+00  2.437e-01 -10.683  < 2e-16 ***
# Age         -3.715e-02  1.052e-02  -3.533 0.000411 ***
# SibSp1       2.351e-01  2.695e-01   0.873 0.382855    
# SibSp2       2.448e-02  6.458e-01   0.038 0.969764    
# SibSp3      -2.158e+00  9.896e-01  -2.181 0.029188 *  
# SibSp4      -1.139e+00  8.294e-01  -1.374 0.169542    
# SibSp5      -1.690e+01  1.740e+03  -0.010 0.992247    
# SibSp8      -1.718e+01  1.261e+03  -0.014 0.989133    
# Parch1       2.061e-01  3.418e-01   0.603 0.546530    
# Parch2       2.059e-01  4.671e-01   0.441 0.659372    
# Parch3      -3.952e-02  1.223e+00  -0.032 0.974231    
# Parch4      -1.719e+01  2.234e+03  -0.008 0.993860    
# Parch5      -1.670e+01  2.001e+03  -0.008 0.993343    
# Parch6      -1.734e+01  3.956e+03  -0.004 0.996503    
# Fare         1.573e-03  2.527e-03   0.622 0.533635    
# EmbarkedC   -1.603e+01  3.956e+03  -0.004 0.996767    
# EmbarkedQ   -1.565e+01  3.956e+03  -0.004 0.996843    
# EmbarkedS   -1.629e+01  3.956e+03  -0.004 0.996716    
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# (Dispersion parameter for binomial family taken to be 1)

#     Null deviance: 829.60  on 622  degrees of freedom
# Residual deviance: 525.04  on 602  degrees of freedom
# AIC: 567.04

# Number of Fisher Scoring iterations: 16

predicciones.02 <- predict(glm.01, test.02, type='response')
predicciones.02

predicciones02.bin <- ifelse (predicciones.02 > 0.5, 1, 0) # Reemplaza los valores de las predicciones para convertirlas en binarias (1,0)
predicciones02.bin
head(predicciones02.bin)
str(predicciones02.bin)

# calcular la precisión del modelo
error.02 <- mean( (predicciones02.bin != test.02$Survived))
precision.02 <- 1 - error.02
precision.02 # el modelo acierta el 82% de las veces si un pasajero sobrevive o no al hundimiento del titanic.csv

# 1. -> K vecinos más cercanos - KNN => clasificación, estima la probabilidad de que un elemento "x" pertenezca a una clase "C", a partir de la información proporcionada.

install.packages('ISLR')
library(ISLR)

# https://www.rdocumentation.org/packages/ISLR/versions/1.2/topics/Caravan

datos.21 <- Caravan # DB de seguros
head(datos.21)
str(datos.21)
summary(datos.21)
summary(datos.21$Purchase)

# Estimar mediante K vecinos si el cliente compra ó no compra! -

any(is.na(datos.21))
# [1] FALSE # Revisar nulls, en este caso no hay nulls en los datos

# Estandarizar las columnas => separar la variable de analisis Purchase
datos.21.compra <- datos.21[,86]
# esto es lo mismo
datos.21.compra <- datos.21$Purchase

# Estandarizar los datos => todas las columnas menos la 86
datos.21.estandarizados <- scale(datos.21[,-86]) 

# Crear los datos de prueba (test.03) y de entrenamiento (train.03), 
# seleccionar las mil primeras filas para datos de pruebas. (test.03)

filas <- 1:1000
filas

test.03.datos <- datos.21.estandarizados[filas,] # incluye las 1000 filas y SUS las columnas
str(test.03.datos)

test.03.compra <- datos.21.compra[filas] # incluye las 1000 filas de la columna Purchase
str(test.03.compra) 
length(test.03.compra) # [1] 1000 filas
length(test.03.compra[[1]]) # [1] 1 columna

train.03.datos <- datos.21.estandarizados[-filas,] # Quita las 1000 filas y sus columnas
str(train.03.datos)

train.03.compra <- datos.21.compra[-filas] # Quita las 1000 filas de la culumna Purchase
str(train.03.compra)
length(train.03.compra) # [1] 4822 filas
length(train.03.compra[[1]]) # [1] 1 columna


# ejecutar el modelo y obtener las predicciones
# install.packages('class')
library(class)
set.seed(90)
predicciones.03.compra <- knn(train.03.datos, test.03.datos, train.03.compra, k=1) # revisar los parámetros k=1 vecino
str(predicciones.03.compra)
length(predicciones.03.compra) # [1] 1000 filas
length(predicciones.03.compra[[1]]) # [1] 1 columna
head(predicciones.03.compra)


# calcular la precisión del modelo
error.03 <- mean(test.03.compra != predicciones.03.compra) # sacar la media de los valores de las pruebas de la columna objetivo es distinto de la predicción
error.03 # [1] 0.116, el error es el del 11%
precision.03 <- 1 - error.03
precision.03 # el modelo acierta el 88% de las veces si el cliente compra ó no

predicciones.03.compra <- knn(train.03.datos, test.03.datos, train.03.compra, k=5) # 5 vecinos
# calcular la precisión del modelo
error.03 <- mean(test.03.compra != predicciones.03.compra) # sacar la media de los valores de las pruebas de la columna objetivo es distinto de la predicción
error.03 # [1] 0.066 disminuye el error con el aumento de k vecinos
precision.03 <- 1 - error.03
precision.03 # el modelo acierta el 93.% de las veces si el cliente compra ó no

# cual es el mejor k para el modelo?
predicciones.03.compra <- NULL
errores <- NULL
for (i in 1:20){
    set.seed(90)
    predicciones.03.compra <- knn(train.03.datos, test.03.datos, train.03.compra, k=i) # i vecinos
    errores[i] <- mean(test.03.compra != predicciones.03.compra)
    # print(errores[i])
}
print(errores)
#  [1] 0.116 0.117 0.074 0.073 0.066 0.065 0.062 0.061 0.058 0.059 0.059 0.059
# [13] 0.059 0.059 0.059 0.059 0.059 0.059 0.059 0.059

valores.k <- 1:20
tabla.errores <- data.frame(errores, valores.k)
print(tabla.errores)
#    errores valores.k
# 1    0.116         1
# 2    0.117         2
# 3    0.074         3
# 4    0.073         4
# 5    0.066         5
# 6    0.065         6
# 7    0.062         7
# 8    0.061         8
# 9    0.058         9  # el k optimo es 9 porque más bajo para el error 0.058% 
# 10   0.059        10
# 11   0.059        11
# 12   0.059        12
# 13   0.059        13
# 14   0.059        14
# 15   0.059        15
# 16   0.059        16
# 17   0.059        17
# 18   0.059        18
# 19   0.059        19
# 20   0.059        20

# 2. -> Árboles de decisión :  https://web.fdi.ucm.es/posgrado/conferencias/JorgeMartin-slides.pdf
# Sirven Representar y Categorizar una serie de condiciones que ocurren de forma sucesiva, para la resolución de un problema.

install.packages = ('rpart')
library(rpart)

# https://www.rdocumentation.org/packages/rpart/versions/4.1-15/topics/kyphosis =>  Representa los datos de los niños que han tenido una cirugía correctiva de la columna vertebral

datos.22 <- kyphosis
str(datos.22)

# Averiguar si la enfermedad kyphosis (relacionada con la columna vertebral), esta present ó absent, el dataSet contiene datos relacionados:
# Age(edad), Number(de vertebras), Start (el número de la primera vértebra (superior) operada.)

arbol.01 <- rpart(kyphosis, data=datos.22) # columna a predecir kyphosis y el dataSet completo
printcp(arbol.01)

# dibujar el arbol de decision - One Way
plot(arbol.01, uniform = T, main='Árbol de decision')
text(arbol.01, use.n = T, all = T)
# dibujar el arbol de decision - Two Way
install.packages("rpart.plot")
library(rpart.plot)
prp(arbol.01)


# 3. -> Random Forest -> Bosques Aleatorios - Algoritmo de clasificación
# combinación entre arboles de decisión en la que cada arbol selecciona una clase y luego se combinan las decisiones de cada uno para seleccionar la mejor opción.
# Maneja cientos de variables de entrada, eficiente en DB grandes

install.packages("randomForest")
library(randomForest, help, pos = 2, lib.loc = NULL)

help(randomForest)
rf.01 <- randomForest(Kyphosis ~ ., data= datos.22)
print(rf.01)

rf.01$predicted # muestra las 81 predicciones

# 3. -> Máquinas de Soporte Vectorial -> SVM -> Conjunto de algoritmos de aprendizaje supervisado para resolver problemas de clasificación y regresión.
# Analizar datos y resolver patrones
# Dado un conjunto de ejemplos de entrenamiento, podemos etiquetar las clases y entrenar una SVM para construir un modelo que prediga la clase de una nueva muestra.

# Se separan las clases en dos espacios lo más amplio posible..

library (ISLR)

help(rpart)

# https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/iris

factor ( datos.23 $ Species)

install.packages("e1071")
library(e1071)

help(svm)

svm.01 <- svm(Species ~ . , data=datos.23)
svm.01

predicc.svm <- predict(svm.01, datos.23[1:4]) # son los datos que contienen las caracteristicas
predicc.svm

tabla <- data.frame(datos.23,predicc.svm)
tabla

# 4. -> k-medias -> no supervisado, usado para clusterización
# Partición de un conjunto de "n" observaciones en "k" grupos, en el que cada observación pertenece al grupo cuyo valor medio es más cercano. - mineria de datos

library(ISLR)
datos.24 <- iris
str(datos.24)

help(kmeans)

library(ggplot2)
kmeans.01 <- ggplot(datos.24, aes(Petal.Length, Petal.Width, color = Species)) + geom_point(size=5)
print(kmeans.01)

set.seed(90)
clusters <- kmeans(datos.24[,1:4], center = 3) # todas las filas y las cuatro columnas, y 3 Species(setosa versicolor virginica); cantidad de sets que deben ser seleccionados, 
clusters

# para ver mejor como ha hecho la clasificación podemos crear una tabla:

> table(clusters$cluster, datos.24$Species)
   
    setosa versicolor virginica
  1      0          2        36
  2     50          0         0
  3      0         48        14

library(cluster)
clusplot(datos.24, clusters$cluster, color=T, shade=T, lablels=0, lines=0)

help(clusplot)

# Redes neuronales => recibir, procesar y transmitir información

# Perceptrón => neurona artificial, la unión de varios crean una red neuronal artificial.
# Se compone de:
# - Canales/Señales de entrada - Dentritas
# - Función de activación - Soma o núcleo - (unión sumadora)
# - Canal de salida y Axón.

 n
 Σ WiXi + b
i=0 

install.packages('MASS')
library(MASS)

# https://www.kaggle.com/andyxie/regression-with-r-boston-housing-price

datos.25 <- Boston
str(datos.25)
head(datos.25)


pairs(datos.25, main="Boston Data") # para ver el plot de todas las variables del data Set

# revisar nulls
any(is.na(datos.25))

# normalizar datos, calculamos el máximo y el minimo de cada una de las columnas
maximo <- apply(datos.25,2,max) # aplica el máximo a las columnas
print(maximo)

minimo <- apply(datos.25,2,min) # aplica el mínimo a las columnas
print(minimo)

max(datos.25$crim)
min(datos.25$crim)

# normalizar los datos - para ver las similitudes entre unas caracteristicas y otras
datos.25.normalizados <- scale(datos.25, center=minimo, scale=maximo-minimo)
datos.25.normalizados <- as.data.frame(datos.25.normalizados)

library(caTools)
# Crea una variable de tal manera que de todos los datos de la columna Objetivo "medv" selecciona aleatoriamente el 70% y la marca como "TRUE" y el otro 30% lo marca como "FALSE"
sample.25 <- sample.split(datos.25.normalizados$medv, SplitRatio = 0.7)
# train.25 => Creamos los datos que tienen TRUE para entrenamiento
train.25 <- subset(datos.25.normalizados, sample.25 == TRUE)
# test.25 => Creamos los datos que tienen FALSE para test
test.25 <- subset(datos.25.normalizados, sample.25 == FALSE)

install.packages("neuralnet")
library(neuralnet)

# Crear la formula para el modelo, nuestro objetivo "medv" lo calcularemos utilizando las suma de las demás caracteristicas
formula.25 <- medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + black + lstat

# modelo
help(neuralnet)
red_neuronal.01 <- neuralnet(formula.25, train.25, hidden = c(5,3), linear.output = TRUE) # Dos capas ocultas de 5 y de 3 neuronas respectivamente, 
# para ajustar más se puede aumentar las capas ocultas y las neuronas
plot(red_neuronal.01)

# Explicación del grafico:
# Entrada => todas las variables exepto nuestro objetivo "medv"
# capa de 5 neuronas
# capa de 3 neuronas
# resultado final => estimación del valor medio medv
# cada uno de los enlaces tendrá un peso

# predicciones
predicc.25 <- compute(red_neuronal.01, test.25[1:13])
str(predicc.25) # lista de elementos de las predicciones del dataSet

predicc.25.Desnormalizados <- predicc.25$net.result * (max(datos.25$medv) - min(datos.25$medv)) + min(datos.25$medv)
test.25.Desnormalizados <- (test.25$medv) * (max(datos.25$medv) - min(datos.25$medv)) + min(datos.25$medv)
error.25 <- sum((test.25.Desnormalizados - predicc.25.Desnormalizados)^2)/ nrow(test.25)
error.25

errores.25 <- data.frame(test.25.Desnormalizados, predicc.25.Desnormalizados)
errores.25

library(ggplot2)

# Relación real vs predicciones
neuronal.01 <- ggplot(errores.25, aes(x=test.25.Desnormalizados, y=predicc.25.Desnormalizados)) + geom_point()
print(neuronal.01)
