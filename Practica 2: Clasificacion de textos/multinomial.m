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
tr=pdata(1:ntr,:);
te=pdata(ntr+1:nrows,:);

#sacar los labels de los datos
trlabels = pdata(1:ntr,ncols);
#las etiquetas son la ultima columna de la matriz pdata y las muestras del entrenamiento son el 90% inicial de pdata
trdata = pdata(1:ntr,1:ncols-1);
#los datos son todas las columnas menos la ultima columna de la matriz pdata y las muestras del entrenamiento son el 90% inicial de pdata
#------------------------------------------------

telabels = pdata(ntr+1:nrows,ncols);
#las etiquetas son la ultima columna de la matriz pdata y las muestras del entrenamiento son el 10% final de pdata
tedata = pdata(ntr+1:nrows,ncols);
#los datos son todas las columnas menos la ultima columna de la matriz pdata y las muestras del entrenamiento son el 10% final de pdata
#------------------------------------------------

#Calculo numero de elementos de Spam(s) y no Spam (h)
Nh=size(find(trlabels==0))(1,1);
Ns=size(find(trlabels==1))(1,1);
#-----------------------------

#Calculo de probabilidades de aparicion de spam o no spam
ph=Nh/nrows;#(no spam)

ps=Ns/nrows;#(spam)
#-------------------------------------

#calculo del vector de probabilidades
vph = sum(trdata(hrows,:)) / sum(sum(trdata(hrows,:)));
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
vps = sum(trdata(srows,:)) / sum(sum(trdata(srows,:)));
#para el segundo vector de probabilidades de spam es el mismo proceso que para el vector de probabilidades de la clase no spam.
#--------------------------------------------------

