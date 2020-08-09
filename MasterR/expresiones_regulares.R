# expresiones_regulares.R

texto <- "Hola buenos DIAS, Que tal estas?"

tGrep <- grep("buenos", texto, ignore.case = FALSE, perl = FALSE)
print (paste("tGrep:", tGrep))

tGrepl <- grepl("DIAS", texto, perl = FALSE, fixed = TRUE)
print (paste("tGrepl:", tGrepl))

# grep return integer(1) => TRUE, si encuentra y 
# grep return integer(0) => FALSE, si no encuentra

# grepl return TRUE, si encuentra y 
# grepl return FALSE, si no encuentra

# vector <- c(sample(1:100,10))

# > vector
#  [1] 78 49 91 69 53 76  5 98 92 31
# > grep(69, vector)
# [1] 4
# > grepl(69, vector)
#  [1] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE