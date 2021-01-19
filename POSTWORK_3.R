#JOSÉ ANDRÉS ECHEVESTE VÁZQUEZ
#POSTWORK 3

#cargando las bibliotecas necesarias:
library(dplyr)
library(lubridate)
library(ggplot2)

#Leyendo los archivos desde la página.
rt17_18<-read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
rt18_19<-read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
rt19_20<-read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

#Con la función select del paquete dplyr selecciona únicamente las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames.
df1<-select(rt17_18, Date:FTR)
df2<-select(rt18_19, Date:FTR)
df3<-select(rt19_20, Date, HomeTeam:FTR)

#Cambiando la fecha de tipo char a tipo Date:
df1<-mutate(df1, Date = as.Date(Date, "%d/%m/%y"))
df2<-mutate(df2, Date = as.Date(Date, "%d/%m/%Y"))
df3<-mutate(df3, Date = as.Date(Date, "%d/%m/%Y"))

#agrupando todo en un dataframe con un rbind
datosTotales<-rbind(df1, df2, df3, deparse.level = 2)

#Elaborando tablas de frecuencias relativas para estimar las siguientes probabilidades:
#Prop.table se utiliza para crear tablas de frecuencia relativa a partir de tablas de frecuencia absoluta

#La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
table1<-table(datosTotales$FTHG)
pt_GC<-prop.table(table1)

#La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
table2<-table(datosTotales$FTAG)
pt_GV<-prop.table(table2)

#La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
table3<-table(datosTotales$FTHG, datosTotales$FTAG)
pt_GT<-prop.table(table3)

#Gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa
barplot(pt_GC, main = "Goles que anota el equipo de casa", xlab = "Cantidad de goles", ylab = "Probabilidad de que ocurra", col= "red", border = "black", ylim = c(0,0.35))

#Gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
barplot(pt_GV, main = "Goles que anota el equipo visitante", xlab = "Cantidad de goles", ylab = "Probabilidad de que ocurra", col= "blue", border = "black", ylim = c(0,0.35))

#HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.
heatmap(pt_GT, xlab="Goles anotados por equipo visitante", ylab = "Goles anotados por equipo de casa", main = "Número de goles anotados")




