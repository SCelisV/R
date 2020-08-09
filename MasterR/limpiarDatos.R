# limpiarDatos.R

# Crear un dataFrame que sea ventasXaños
año <- c(2018,2019,2020)
enero <- c(120,100,80)
febrero <- c(80,90,140)
marzo <- c(110,150,70)
datos.01 <- data.frame(año=año, enero=enero, febrero=febrero, marzo=marzo)
print(datos.01)

#    año enero febrero marzo
# 1 2018   120      80   110
# 2 2019   100      90   150
# 3 2020    80     140    70

# gather {tidyr} => uné varias columnas en una única columna

datos.02 <- gather(datos.01, "Mes", "Ingresos", enero:marzo)
print(datos.02)

#    año     Mes Ingresos
# 1 2018   enero      120
# 2 2019   enero      100
# 3 2020   enero       80
# 4 2018 febrero       80
# 5 2019 febrero       90
# 6 2020 febrero      140
# 7 2018   marzo      110
# 8 2019   marzo      150
# 9 2020   marzo       70

# Spread es el opuesto de gather, una columna en varias columnas
datos.03 <- spread(datos.02, "Mes", "Ingresos")
print(datos.03)

#    año enero febrero marzo
# 1 2018   120      80   110
# 2 2019   100      90   150
# 3 2020    80     140    70

datos.04 <- data.frame(columna=c('a.b','c.d','e.f'))
print(datos.04)

#   columna
# 1     a.b
# 2     c.d
# 3     e.f

# separate una columna en varias columnas
datos.05 <- separate(datos.04,columna,c('c1','c2'))
print(datos.05)

#   c1 c2
# 1  a  b
# 2  c  d
# 3  e  f

# une varias columnas en una columna
datos.06 <- unite(datos.05,columna,'c1','c2', sep="-")
print(datos.06)

#   c1 c2
# 1  a  b
# 2  c  d
# 3  e  f

