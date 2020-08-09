# boxplots.R => gráfico para representar una serie númerica a traves de los quartiles tres grupos.
# Q1 - Inferior 25%
# Q2 - Mediana 50% 
# Q3 - Superior 25%

datos.12 <- mtcars
#eje de las X debe ser Discreta (x=factor(cyl)) y la variable Continua en Y (mpg -> millas por galon)
# datos.12$cyl
#  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
# factor(datos.12$cyl)
#  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
# Levels: 4 6 8

boxplot.01 <- ggplot(datos.12, aes(x=factor(cyl), y=mpg))
boxplot.01 <- boxplot.01 + geom_boxplot()
print(boxplot.01)


boxplot.02 <- ggplot(datos.12, aes(x=factor(cyl), y=mpg)) + geom_boxplot()
print(boxplot.02)

boxplot.03 <- ggplot(datos.12, aes(x=factor(cyl), y=mpg)) + geom_boxplot(fill='green', linetype=4)
print(boxplot.03)

boxplot.04 <- ggplot(datos.12, aes(x=factor(cyl), y=mpg)) + geom_boxplot(aes(fill=factor(cyl)))
print(boxplot.04)

boxplot.05 <- ggplot(datos.12, aes(x=factor(cyl), y=mpg)) + geom_boxplot(aes(fill=factor(cyl))) + theme_dark()
print(boxplot.05)

boxplot.06 <- ggplot(datos.12, aes(x=factor(cyl), y=mpg)) + geom_boxplot(aes(fill=factor(cyl))) + theme_light()
print(boxplot.06)

boxplot.07 <- ggplot(datos.12, aes(x=factor(cyl), y=mpg)) + geom_violin(aes(fill=factor(cyl))) + theme_dark()
print(boxplot.07)

boxplot.08 <- ggplot(datos.12, aes(x=factor(cyl), y=mpg)) + geom_violin(aes(fill=factor(cyl))) + theme_light()
print(boxplot.08)