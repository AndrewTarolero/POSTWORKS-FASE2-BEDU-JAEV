#JOSÉ ANDRÉS ECHEVESTE VÁZQUEZ
#POSTWORK 1

#LEYENDO ARCHIVO DESDE LA PÁGINA
resultados<-read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

#Columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG)
GAC <- resultados$FTHG

#Columnas de número de goles anotados por los equipos que jugaron como visitante (FTAG)
GAV <- resultados$FTAG

#Cómo funciona la función table
?table

table1<-table(GAC)
table2<-table(GAV)

#La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
prop.table(table1)

#La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
prop.table(table2)

#La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)
table3<-table(GAC,GAV)
prop.table(table3)
