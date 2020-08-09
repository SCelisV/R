# db_01.R
# install.packages("RSQLite")
# conectarme con una base de datos
library(RSQLite)
con <- dbConnect(RSQLite::SQLite(), "db")
# class(con)
# [1] "SQLiteConnection"
# attr(,"package")

# dbWriteTable(con, "coches", mtcars)
dbReadTable(con, "coches")
result <- dbSendQuery(con, "SELECT * from coches")
# dbFetch(result)
# dbClearResult(result)
# # dbDisconnect(con)
# result_01 <- dbSendQuery(con, "SELECT * FROM coches WHERE cyl = 8")
# dbFetch(result_01)
# dbClearResult(result_01)
# # dbDisconnect(con)