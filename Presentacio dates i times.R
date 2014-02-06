# Codi exemple Presentació Dates and Times --------------------------------
# Grup d'usuaris d'R de Barcelona
# Lluís Ramon
# 5/2/2014 o 5/2/14 o 5-2-14 o ... date()

# Modificar tamany lletra: Tools -> Global Options -> Apperarance


# Tractament Dates --------------------------------------------------------

Sys.Date()

is(Sys.Date())

rugbcn <- read.csv2("rugbcn.csv")

head(rugbcn)
str(rugbcn)

# De character a Date
as.Date(rugbcn$aniversari) # Per defecte intenta "%Y-%m-%d" then "%Y/%m/%d"

# Passar el com es la Date al camp format
as.Date(rugbcn$aniversari, format = "%d/%m/%Y")

rugbcn$aniversari <- as.Date(rugbcn$aniversari, format = "%d/%m/%Y")
rugbcn$inici <- as.Date(rugbcn$inici, format = "%d-%b-%Y")
rugbcn$reunio <- as.Date(rugbcn$reunio)
# Per saber quin format mirar el help ?strftime

str(rugbcn)

# De Date a character
format(rugbcn$reunio)
is(format(rugbcn$reunio))
as.character(rugbcn$reunio)

# Classes que pot convertir as.Date
methods(as.Date)

# Operacions amb dates
?Ops.Date

rugbcn$reunio
rugbcn$reunio + 1 # Sumar/restar dies
rugbcn$reunio - rugbcn$inici
rugbcn$reunio > rugbcn$inici

months(rugbcn$reunio)
months(rugbcn$reunio, abbreviate = TRUE)
weekdays(rugbcn$reunio)
quarters(rugbcn$reunio)

Sys.getlocale() # depen del local

# Crar variables any, mes,... Per agregar informacio
format(rugbcn$reunio, format = "%Y")
format(rugbcn$reunio, format = "%m")

# Crear sequencia de Dates camp by
?seq.Date
seq(rugbcn$inici[1], rugbcn$reunio[1], by =  "day")
seq(rugbcn$inici[1], rugbcn$reunio[1], by =  "week")

# Tractament Date-Times --------------------------------------------------------

rugbcn <- read.csv2("rugbcn.csv")

# De Character a POSIXct
(aniversari <- strptime(rugbcn$aniversari, format = "%d/%m/%Y"))
is(aniversari)

# Si tenim l'any, mes, dia, ...
ISOdate(rugbcn$Any, rugbcn$Mes, rugbcn$Dia, rugbcn$Hora, rugbcn$Minut, rugbcn$Segon)

rugbcn$inici_cal <- ISOdate(rugbcn$Any, rugbcn$Mes, rugbcn$Dia, rugbcn$Hora, rugbcn$Minut, rugbcn$Segon)
is(rugbcn$inici_cal)

# De POSIXct a Character
inici_cal <- as.character(rugbcn$inici_cal)
is(inici_cal)

# De POSIXct a Date (i viceversa)
aniversari <- as.Date(aniversari)
is(aniversari)

aniversari <- as.POSIXct(aniversari)
is(aniversari)

# POSIXt: Existeix POSIXct i POSIXlt

date_time <- Sys.time()
is(date_time)
unclass(date_time)
# number of seconds since the beginning of 1970

date_time <- as.POSIXlt(date_time)
is(date_time)
unclass(date_time)
# named list of vectors sec, min , hour, etc

# questions de timezone, normalment usar POSIXct

# OPeracions amb POSIXt funciona igual
?Ops.POSIXt

rugbcn$inici_cal
rugbcn$inici_cal + 1 # Ara sumem segons
rugbcn$inici_cal > rugbcn$inici_cal + 1

months(rugbcn$inici_cal)

format(rugbcn$inici_cal, format = "%Y")
format(rugbcn$inici_cal, format = "%m")

# Sequence de POSIXlt 
seq(rugbcn$inici_cal[1], rugbcn$inici_cal[1] + 25, by =  "day")
seq(rugbcn$inici[1], rugbcn$reunio[1], by =  "week")

# Exemples lubridate ------------------------------------------------------

library(lubridate)

rugbcn <- read.csv2("rugbcn.csv")
str(rugbcn)

# Parsing Dates amb lubridate
dmy(rugbcn$inici)

rugbcn$aniversari <- dmy(rugbcn$aniversari)
rugbcn$inici <- dmy(rugbcn$inici)
rugbcn$reunio <- ymd(rugbcn$reunio)

# Numeric sense problemes
as.Date(as.character(rugbcn$presentar), format = "%d%m%Y")
rugbcn$presentar <- dmy(rugbcn$presentar)

?dmy_hms

is(rugbcn$reunio)

# Obtenir dia, mes, any...
day(rugbcn$reunio)
month(rugbcn$reunio)
year(rugbcn$reunio)

# Any bixest
leap_year(rugbcn$aniversari)

# Qualsevol format de data. Inclus formats diferents en un mateix vector.
parse_date_time("1979L05L27", c("dmy", "dym", "mdy", "myd", "ydm", "ymd"))
parse_date_time(c("11-oct-2011", "2011-11-03",  "25/11/1989"), c("dmy", "dym", "mdy", "myd", "ydm", "ymd"))

# Afefgeixo petició de l'Aleix sumar un periode (dies, mesos ..) a una data
jan <- ymd_hms("2010-01-15 03:04:05")

jan + dseconds(1)
jan + dminutes(5.5)
jan + dhours(4)
jan + ddays(3)
jan + dweeks(9)
# No existeix dmonths. Cada mes té diferent nombre dies i per tant segons
jan + dyears(9)

# Afefgeixo petició del Cristian sobre sumar sis mesos i quedarte amb el 
# darrer dia del mes 
jan <- ymd("2010-01-15")
rollback(jan %m+% months(7))