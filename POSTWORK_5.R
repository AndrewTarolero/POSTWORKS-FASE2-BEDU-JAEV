#JOSÉ ANDRÉS ECHEVESTE VÁZQUEZ
#POSTWORK 5

#cargando las bibliotecas necesarias:
library(dplyr)
library(lubridate)

# A partir del conjunto de datos de soccer de la liga española de las 
# temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, 
# que contenga las columnas date, home.team, home.score, away.team y away.score; 
# esto lo puedes hacer con ayuda de la función select del paquete dplyr. 
# Luego crea un directorio de trabajo y con ayuda de la función write.csv 
# guarde el data frame como un archivo csv con nombre soccer.csv. 
# Puedes colocar como argumento row.names = FALSE en write.csv.

#Leyendo los archivos desde la página.
rt17_18<-read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
rt18_19<-read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
rt19_20<-read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

#Con la función select del paquete dplyr selecciona únicamente las columnas Date, HomeTeam, AwayTeam, FTHG y FTAG; esto para cada uno de los data frames.
df1<-select(rt17_18, Date:FTAG)
df2<-select(rt18_19, Date:FTAG)
df3<-select(rt19_20, Date, HomeTeam:FTAG)

#Cambiando la fecha de tipo char a tipo Date:
df1<-mutate(df1, Date = as.Date(Date, "%d/%m/%y"))
df2<-mutate(df2, Date = as.Date(Date, "%d/%m/%Y"))
df3<-mutate(df3, Date = as.Date(Date, "%d/%m/%Y"))

#verificando los nombres de los argumentos de cada data frame
names(df1)
names(df2)
names(df3)

#agrupando todo en un dataframe con un rbind
SmallData<-rbind(df1, df2, df3, deparse.level = 2)
names(SmallData)#Revisamos los nombres del df

#Renombramos y reordenamos las columnas para poder hacer uso de la función de fbRanks
SmallData<-rename(SmallData, date = Date, home.team = HomeTeam, away.team = AwayTeam, home.score = FTHG, away.score = FTAG)
SmallData = SmallData [, c(1, 2, 4, 3, 5)]

names(SmallData) #verificamos el cambio de nombres y el reordenamiento 

#creando un directorio de trabajo 
setwd("C:/Users/José Andrés/Desktop/DATA SCIENCE/BEDU/FASE_2/PROGRAMACIÓN CON R/SESIÓN_5")

#Creando el archivo soccer.csv
write.csv(SmallData, file="soccer.csv", row.names = F)

# Con la función create.fbRanks.dataframes del paquete fbRanks importa el archivo soccer.csv a R 
# y al mismo tiempo asignarlo a una variable llamada listasoccer. 
# Se creará una lista con los elementos scores y teams que son data frames
# listos para la función rank.teams. 
# Asigna estos data frames a variables llamadas anotaciones y equipos.

library(fbRanks)
listasoccer<-create.fbRanks.dataframes(scores.file="soccer.csv")
listasoccer
#guardado scores y teams en nuevas variables 
anotaciones <- listasoccer$scores
equipos <- listasoccer$teams

# Con ayuda de la función unique crea un vector de fechas (fecha) que no se repitan 
# y que correspondan a las fechas en las que se jugaron partidos. 
# Crea una variable llamada n que contenga el número de fechas diferentes.
fecha <- c(listasoccer$scores$date)
n<-unique(fecha)

# Posteriormente, con la función rank.teams y usando como argumentos 
# los data frames anotaciones y equipos, 
# crea un ranking de equipos usando únicamente datos 
# desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, 
# estas fechas las deberá especificar en
# max.date y min.date. Guarda los resultados con el nombre ranking.

max(n) #obteniendo la última fecha del vector 
min(n) #obtenuendo la primera fecha del vector

?rank.teams

#guardando resultados 
ranking<-rank.teams(scores = anotaciones, teams = equipos, max.date = "2020-07-19", min.date = "2017-08-18")

# Finalmente estima las probabilidades de los eventos, el equipo de casa gana, 
# el equipo visitante gana o el resultado es un empate para los partidos 
# que se jugaron en la última fecha del vector de fechas 
# fecha. Esto lo puedes hacer con ayuda de la función predict y usando como argumentos ranking 
# y fecha[n] que deberá especificar en date.

?predict()

#obteniendo las probabilidades de los partidos 
predict(ranking, max.date = "2020-07-19", min.date = "2017-08-18", n=100000)
