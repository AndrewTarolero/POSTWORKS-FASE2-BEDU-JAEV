#JOSÉ ANDRÉS ECHEVESTE VÁZQUEZ
#POSTWORK 2

#cargando las bibliotecas necesarias:
library(dplyr)
library(lubridate)
#Leyendo los archivos desde la página.
rt17_18<-read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
rt18_19<-read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
rt19_20<-read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

#Obteniendo una mejor idea de las características de los data frames al usar las funciones: str, head, View y summary

#temporada 17/18
str(rt17_18)
head(rt17_18)
View(rt17_18)
summary(rt17_18)

#temporada 18/19
str(rt18_19)
head(rt18_19)
View(rt18_19)
summary(rt18_19)

#temporada 19/20
str(rt19_20)
head(rt19_20)
View(rt19_20)
summary(rt19_20)

#Con la función select del paquete dplyr selecciona únicamente las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames.
df1<-select(rt17_18, Date:FTR)
df2<-select(rt18_19, Date:FTR)
df3<-select(rt19_20, Date, HomeTeam:FTR)

#Cambiando la fecha de tipo char a tipo Date:
df1<-mutate(df1, Date = as.Date(Date, "%d/%m/%y"))
df2<-mutate(df2, Date = as.Date(Date, "%d/%m/%Y"))
df3<-mutate(df3, Date = as.Date(Date, "%d/%m/%Y"))

#verificando que la fecha haya cambiando a tipo date
str(df1)
str(df2)
str(df3)

?rbind.data.frame
#verificando los nombres de los argumentos de cada data frame
names(df1)
names(df2)
names(df3)

#agrupando todo en un dataframe con un rbind
datosTotales<-rbind(df1, df2, df3, deparse.level = 2)
