#JOS� ANDR�S ECHEVESTE V�ZQUEZ
#POSTWORK 7

library(mongolite)
#Previamente se ha cargado el fichero a utilizar en MongoDB
MyDB<- mongo(
      collection = "match",
      db = "match_games",
      url = "mongodb+srv://ANDREW:Pepino99@cluster0.8gjrv.mongodb.net/test",
      verbose = FALSE,
      options = ssl_options())

#Realizar un count para conocer el n�mero de registros que se tiene en la base
MyDB$count()

# Realiza una consulta utilizando la sintaxis de Mongodb, 
# en la base de datos para conocer el n�mero de goles que meti� el Real Madrid 
# el 20 de diciembre de 2015 y contra que equipo jug�, �perdi� � fue goleada?
query1<-MyDB$find('{"date":"2015-12-20"}')

class(consutlta1)#verificar la clase df para poder extraer el dato de inter�s

queryFinal<-query1[4,]#extrayendo la fila donde se encuentra el resultado deseado

queryFinal # Real Madrid jug� contra el Vallecano el 20/12/2015 y goleo 10 a 2

#Desconectando de la base de datos
MyDB$disconnect(gc = TRUE)
