# plotly.R => Creación de gráficos interactivos

# install.packages ("plotly")
# library(plotly)
# library(ggplot2)

# https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/mtcars => df mtcars 
# comparar dos variables continuas
# wt 	=> Weight (1000 lbs) 
# mpg => Miles/(US) gallon 
datos.17 <- mtcars
head(datos.17)
scatt.13 <- ggplot(datos.17, aes(mpg, wt)) + geom_point()
print (scatt.13)

plotly.01 <- ggplotly(scatt.13)
print(plotly.01)

# ABRE EL FICHERO EN EL QUE PUEDES REALIZAR LAS CONSULTAS INTERACTIVAS... (ZOOM...ETC)
# file:///tmp/RtmpTvELWL/viewhtml1c334c5ff43/index.html
