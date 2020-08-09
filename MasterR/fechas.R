# fechas.R

# Sys.time()
# [1] "2020-07-07 21:45:04 CEST"

# > Sys.Date()
# [1] "2020-07-07"
fecha_01 <- Sys.Date()
print(fecha_01) # "2020-07-07"

# class(fecha_01)
# [1] "Date"

fecha_02 <- 2020-07-07
print(fecha_02) # 2006

# class(fecha_02)
# [1] "numeric"

fecha_03 <- "2020-07-07"
print(fecha_03) # "2020-07-07"

# Convertir una fecha "character" to Date

# class(fecha_03)
# [1] "character"

fecha_03 <- as.Date("2020-07-07")
# class(fecha_03)
# [1] "Date"

fecha_04 <- as.Date("04-01-20", format="%m-%d-%y")
print(fecha_04) # "2020-04-01"

# class(fecha_04)
# [1] "Date"

fecha_05 <- Sys.time()
print(fecha_05)
class(fecha_05)

# fecha_05 # "2020-07-07 22:01:01 CEST"
class(fecha_05) # "POSIXct" "POSIXt" 

fecha_06 <- strptime("23:51:00", format="%H:%M:%S")
print(fecha_06) # "2020-07-07 23:51:00 CEST"
class(fecha_06) # "POSIXlt" "POSIXt" 

# format

# ?strptime
# format(Sys.time(), "%a %b %d %X %Y %Z")
# [1] "mar jul 07 23:31:02 2020 CEST"
# Sys.time()
# [1] "2020-07-07 23:40:36 CEST"
# format(Sys.time(), format="%H:%M:%S")
# [1] "23:40:37"

# %d Day of the month (01–31).
# %H Hours (00–23).
# %I Hours (01–12).
# %j Day of year (001–366).
# %m Month (01–12).
# %M Minute (00–59).
# %p AM/PM indicator.
# %S Second as decimal number (00–61).
# %U Week (00–53); the first Sunday as day 1 of week 1.
# %w Weekday (0–6, Sunday is 0).
# %W Week (00–53); the first Monday as day 1 of week 1.
# %y Year without century (00–99). Don’t use.
# %Y Year with century.
# %z (output only.) Offset from Greenwich;-0800is 8 hours west of.
# %Z (output only.) Time zone as a character string (empty if not available)
# %b Month English. Jan, Feb, Mar
# %B Month English. January, February, March
