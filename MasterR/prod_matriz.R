# producto matrices
# producto matricial => operador %*% 
# operador t => matriz opuesta
# funcion crossprod => producto matricial cruzado de dos matrices, es decir, 
# la traspuesta de la primera matriz multiplicada por la segunda. 
# Si no se especifica la segunda matriz, R la toma igual que a segunda. 

matriz.a <- matrix(1:6, 2,3)
matriz.a
#      [,1] [,2] [,3]
# [1,]    1    3    5
# [2,]    2    4    6

matriz.b <- matrix(2:7, 3, 2, 2)
matriz.b
#      [,1] [,2]
# [1,]    2    3
# [2,]    4    5
# [3,]    6    7

# traspuesta de la matriz - matrix
t(matriz.a)
#      [,1] [,2]
# [1,]    1    2
# [2,]    3    4
# [3,]    5    6

# producto matricial  => Dos matrices A y B se dicen multiplicables si el número de columnas de A coincide con el número de filas de B
# A_{m*n}*B_{n*p}=C_{m*p}

# El elemento c_{ij} de la matriz producto se obtiene multiplicando cada elemento de la fila i de la matriz A por cada elemento de la columna j de la matriz B y sumándolos.

#  1*2+3*4+5*6=2+12+30=44     1*3+3*5+5*7=3+15+35=53
#  2*2+4*4+6*6=4+16+36=56     2*3+4*5+6*7=6+20+42=68

matriz.a %*% matriz.b
#      [,1] [,2]
# [1,]   44   53
# [2,]   56   68

# 2*1+3*2=2+6=8       2*3+3*4=6+12=18     2*5+3*6=10+18=28
# 4*1+5*2=4+10=14     4*3+5*4=12+20=32    4*5+5*6=20+30=50
# 6*1+7*2=6+14=20     6*3+7*4=18+28=46    6*5+7*6=30+42=72

matriz.b %*% matriz.a
#      [,1] [,2] [,3]
# [1,]    8   18   28
# [2,]   14   32   50
# [3,]   20   46   72

t(matriz.a) %*% (matriz.a)
# ó
crossprod(matriz.a)
#      [,1] [,2] [,3]
# [1,]    5   11   17
# [2,]   11   25   39
# [3,]   17   39   61

t(matriz.a)%*%t(matriz.b)
# ó
crossprod(matriz.a, t(matriz.b))
#      [,1] [,2] [,3]
# [1,]    8   14   20
# [2,]   18   32   46
# [3,]   28   50   72

# La función solve permite obtener la inversa de una matriz cuando sólo se la da un argumento, 
# El determinante de una matriz se obtiene mediante la función det . 

x <- matrix(1:10, 5,2,)
x
#      [,1] [,2]
# [1,]    1    6
# [2,]    2    7
# [3,]    3    8
# [4,]    4    9
# [5,]    5   10

solve(crossprod(x))
#        [,1]   [,2]
# [1,]  0.264 -0.104
# [2,] -0.104  0.044

det(crossprod(x))
# [1] 1250

# La función solve permite resolver sistemas de ecuaciones lineales cuando se le dan dos argumentos. 

# 3x + 2y = 5
# x − y = 0

# ó

# | 3  2 || x | = 5
# | 1 -1 || y | = 0

# ó

datos.01 = matrix(c(3,2,1,-1),ncol=2,by=T)
datos.01
#      [,1] [,2]
# [1,]    3    2
# [2,]    1   -1

datos.02 = c(5,0)
datos.02
# [1] 5 0

solve(datos.01, datos.02)
# [1] 1 1