#POSTWORK 4
#EQUIPO 22:
#Flor de María Medina García
#José Andrés Echeveste Vázquez
#José Marcos García Gómez 

library(dplyr)

#Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R, 
#los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

liga <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

#Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los números de 
#goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron 
#como visitante (FTAG)

FTGH <- liga$FTHG
FTAG <- liga$FTAG

#Posteriormente elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

# -La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)

x <- c(FTGH)
eq.loc <- table(x)
eq.loc
x.pm <- prop.table(eq.loc)
x.pm

# -La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)

y <- c(FTAG)
eq.vis <- table(y)
eq.vis
y.pm <- prop.table(eq.vis)
y.pm

# -La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como 
#visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)

loc.vis <- table(x, y)
loc.vis
lv.pc <- prop.table(loc.vis)
lv.pc

# 1.Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), 
#y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir 
#estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
#(PROBABILIDAD CONDICIONAL)

pdc.pm <- sapply(1:nrow(y.pm), function(i) {
  unlist(sapply(1:nrow(x.pm), function(j) {
    x.pm[j]*y.pm[i]
  }))
})

colnames(pdc.pm) <- c("0", "1", "2", "3", "4", "5")
pdc.pm

t.coc <- lv.pc/pdc.pm
t.coc #tabla de cocientes

###
# 2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior.
# Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. 


liga <- soccer_19_20 %>% 
  select(FTHG,FTAG)


Casa <- table(datos$FTHG)/sum(table(datos$FTHG))
Casa
Visita <- table(datos$FTAG)/sum(table(datos$FTAG))
Visita

tabla <- table(datos)
tabla2 <- prop.table(tabla)
tabla2

## Bootstrap

repet = 100 # Numero de veces que se realizarÃ¡ el bootstrap

n=length(datos$FTHG)
tablas = matrix(0, 7,6)

for (m in 1:repet) {
  sel <- sample(1:n,size = n,replace = T) # muestra con reemplazo para realizar bootstrap
  # sel2 <- sample(1:n,size = n,replace = T) 
  ## Se calcula de nuevo todos los vlaores
  b_casa <- datos$FTHG[sel]
  b_visita <- datos$FTAG[sel]
  
  b_Casa_t <- table(b_casa)/sum(table(b_casa))
  b_Visita_t <- table(b_visita)/sum(table(b_visita))
  
  b_tabla <- table(as.data.frame(t(rbind(b_casa,b_visita))))
  b_tabla_p <- prop.table(b_tabla)
  
  b_tabla_fin<-matrix(0, 7,6)
  
  for (i in 1:nrow(b_tabla_p)) {
    for (j in 1:ncol(b_tabla_p)) {
      b_tabla_fin[i,j] = b_tabla_p[i,j]/(b_Casa_t[i]*b_Visita_t[j])
    }
  }
  
  tablas = tablas + b_tabla_fin # se suman los resultados para calcular un promedio de como se comporta
}
tablas/repet #tabla de cocientes con el bootstrap

# Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1
# (en tal caso tendríamos independencia de las variables aleatorias X y Y).

# En la mayoría de los casos los cocientes de las posibles combinaciones son cercanos a 1 ya sea en cantidad mayor o menor, por lo que podemos atribuir a que en la mayoría de dichos resultados no habrá tanta influencia a que el equipo sea local o visitante. 
# Notamos que existen únicamente 6 resultados los cuales son poco comunes que ocurran ya que para que sucedan depende de ciertos factores, los resultados anómalos son:

# 6-0, 5-0 y 5-2 a favor del equipo local, esto implicaría por ejemplo que la defensiva del equipo visitante fuera muy débil o que en general la visita tenga una plantilla por debajo de la media general o bien que la plantilla local posea un equipo encima de la media. 
# 3-0 y 5-0 a favor del equipo visitante, esto podría implicar que el equipo visitante tenga probablemente superioridad numérica en el campo. 
# 4-4 este resultado es muy poco común ya que un factor del cual podría depender es que ambas defensivas sean muy malas y sus ofensivas sean efectivas en un alto porcentaje.

# Las anteriores implicaciones mencionadas son solo algunas de las posibles dependencias para que se den estos resultados,  ya que pueden existir muchos más factores.
# En los resultados donde el cociente es 0 significa que no se han observado combinaciones de esos goles.
