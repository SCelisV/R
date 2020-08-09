
# ContinuousBivariateDistribution.R

# i <- ggplot(movies, aes(year, rating))i + 
# geom_bin2d(binwidth = c(5, 0.5))xmax, xmin, ymax, ymin, alpha, color, fill, linetype, size, weight


library(ggplot2)
library(ggplot2movies)

pelis.01 <- movies
head(pelis.01)

# geom_bind2d => Añade el mapa de calor 2d.
# Divides the plane into rectangles, counts the number of cases in each rectangle, and then (by default) maps the number of cases to the rectangle's fill.
# This is a useful alternative to geom_point() in the presence of overplotting. 

mapa.01 <- ggplot(pelis.01, aes(x=year, y=rating))
mapa.01 <- mapa.01 + geom_bin2d()
print(mapa.01)

mapa.02 <- ggplot(pelis.01, aes(x=year, y=rating)) + geom_bin2d()
print(mapa.02)

mapa.03 <- ggplot(pelis.01, aes(x=year, y=rating)) + geom_bin2d() + scale_fill_gradient(low='blue', high='red')
print(mapa.03)

# geom_density2d


mapa.04 <- ggplot(pelis.01, aes(x=year, y=rating)) + geom_density2d() 
print(mapa.04)

mapa.05 <- ggplot(pelis.01, aes(x=year, y=rating)) + geom_density2d(linetype=4, size=1, alpha=0.4, color='red' ) + theme_light()
print(mapa.05)

mapa.06 <- ggplot(pelis.01, aes(x=year, y=rating)) + geom_density2d(linetype=4, size=2, alpha=0.8 ) + theme_light() + scale_color_gradient(low="blue", high="red")
print(mapa.06)

mapa.07 <- ggplot(pelis.01, aes(x=year, y=rating)) + stat_density2d(linetype=4, size=1, alpha=0.6 ) + theme_light() + scale_color_gradient(low="blue", high="red") +   
    labs(y = "rating",
        x = "year",
        title = "Rating pelis by year - mapa.07")

print(mapa.07)

mapa.08 <- ggplot(pelis.01, aes(x=year, y=rating)) + stat_density2d(aes(fill = stat(level)), geom="polygon")  + 
scale_fill_gradient(low = "lightskyblue1", high = "darkred") +
  theme(legend.position = "none") +
  labs(y = "rating",
       x = "year",
       title = "Rating pelis by year - mapa.08")
print(mapa.08)