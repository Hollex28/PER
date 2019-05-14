#!/usr/bin/octave -qf

if (nargin!=1)
	printf("Usage: multinomial.m <data_filename>");
	exit(1);
end

arglist=argv();
datafile=arglist{1};
disp("Loading data...");
load(datafile);
disp("Data load complete.");

# 90% de entrenamiento y 10 para test (division)
[nrows, ncols] = size(data);
rand("seed", 23);
perm = randperm(nrows);
pdata = data(perm,:);
trper = 0.9;
ntr=floor(nrows*trper);
nte=nrows-ntr;
##tr y te son datos surperfluos ya que no se utilizan
#tr=pdata(1:ntr,:);
#te=pdata(ntr+1:nrows,:);
disp("parte 1");

#sacar los labels de los datos
trlabels = pdata(1:ntr,ncols);
#las etiquetas son la ultima columna de la matriz pdata y las muestras del entrenamiento son el 90% inicial de pdata
trdata = pdata(1:ntr,1:ncols-1);
disp("parte 2");
#los datos son todas las columnas menos la ultima columna de la matriz pdata y las muestras del entrenamiento son el 90% inicial de pdata
#------------------------------------------------

telabels = pdata(ntr+1:nrows,ncols);
#las etiquetas son la ultima columna de la matriz pdata y las muestras del entrenamiento son el 10% final de pdata
tedata = pdata(ntr+1:nrows,1:ncols-1);
#los datos son todas las columnas menos la ultima columna de la matriz pdata y las muestras del entrenamiento son el 10% final de pdata
#------------------------------------------------
disp("parte 3");
#Calculo numero de elementos de Spam(s) y no Spam (h)
Nh=size(find(trlabels==0))(1,1);
Ns=size(find(trlabels==1))(1,1);
#-----------------------------
#Vector que contiene numeros de filas de la matriz de datos con las diferentes etiquetas
# datos[ x x x 1; x x x 0; x x x 1; x x x 1; x x x 0]
# hfilas= [2:5] sfilas = [1;3;4]
sfilas=find(trlabels==1);
hfilas=find(trlabels==0);
disp("parte 4");
#---------------------------

#Calculo de probabilidades de aparicion de spam o no spam
ph=Nh/ntr;#(no spam)

ps=Ns/ntr;#(spam)
#-------------------------------------
disp("parte 5");
#calculo del vector de probabilidades
vph = sum(trdata(hfilas,:)) / sum(sum(trdata(hfilas,:)));
##INICIO NOTA GRANDE
#el primer sumatorio es la suma por columnas de la matriz de la clase no spam, dando como resultado el numero de tokens que contienen los mensages de la clase no spam
#ejm:
# [1 2 3 4]
#+|4 2 4 1|
# [1 1 2 0]
#Res---------
# [6 5 9 5]
#Y el segundo sumatorio (por el cual se divide el resultado anterior) es sumar todas las columnas del vector resultado del primer sumatoiro
#ejm:
# [6 5 9 5] -> 6+5+9+5 = 25
#y al dividir el vector del primer sumatorio por el resultado de este ultimo sumatorio nos normaliza el vector
# ejm:
# [6 5 9 5]/25 --> [6/25 5/25 9/25 5/25] = [0.24 0.2 0.36 0.2] que si sumamos los componentes de este vector -> 0.24+0.2+0.36+0.2 = 1
##FIN NOTA GRANDE##

vps = sum(trdata(sfilas,:)) / sum(sum(trdata(sfilas,:)));
disp("parte 6");

#para el segundo vector de probabilidades de spam es el mismo proceso que para el vector de probabilidades de la clase no spam.
#--------------------------------------------------
#Clasificador Multinomial
w_h = log(vph);
w_h0 = log(ph);
w_s = log(vps);
w_s0 = log(ps);
disp("parte 7");

gh = tedata * w_h' + w_h0;
gs = tedata * w_s' + w_s0;
disp("parte 8");
#-------------------------------------------------
#Clasificamos segun su valor de gh y gs obtenido
clasificacion = (gh < gs);
disp("parte 9");
#Si gh es menor que gs la muestra se clasifica como spam y en caso contrario como no spam (RECUERDA QUE 1 ES SPAM(S) Y 0 es No Spam(H))
#-------------------------------------------------
#Ahora sacamos en Nº de muestras mal clasificadas
aux = clasificacion != telabels;
Nmuestas = size(telabels)(1,1)
Error = size(find(aux==1))(1,1)
PorcentageDeError = Error/nte
#------------------------------------------------
