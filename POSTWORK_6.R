#JOSÉ ANDRÉS ECHEVESTE VÁZQUEZ
#POSTWORK 6

library(TSA)
library(lubridate)

#Importando el conjunto de datos match.data.csv
Datos<-read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-06/Postwork/match.data.csv")

#Agregando una nueva columna "sumagoles" que contenga la suma de goles por partido.
Datos$sumagoles<-Datos$home.score + Datos$away.score

#verificando que se ha agregado la columna "sumagoles"
head(Datos)

# Convirtiendo la fecha a tipo date
Datos$date <- as.Date(Datos$date)
class(Datos$date) #verificando la clase

#Obteniendo los meses
Datos$Mes<- months(Datos$date)

#Obteniendo los años
Datos$Año <- format(Datos$date,format="%Y")

#Obteniendo el promedio por mes de la suma de goles.
#Agregando 'sumagoles' en meses y año 
?aggregate
PGPM<-aggregate(sumagoles ~ Mes + Año , Datos , mean)
?ts

#Creando la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
PGPM.ts<-ts(PGPM[,3], start = 2010, end=2019, frequency = 12)

#Graficando la serie de tiempo.
plot(PGPM.ts, 
     main = "Promedio de goles por mes de la liga española",
     ylab = "Goles",
     xlab = "Tiempo",
     sub = "Agosto de 2010 - Diciembre de 2019", col="blue")
?plot
