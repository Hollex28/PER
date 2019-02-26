#!/usr/bin/octave -qf

printf("Ejercicios Basicos de la Practica 0:\n ----------------------------------------------------------- \n");
v1 = [1 3 8 9]
v2 = [-1 8 2 -3]
matriz = v1' * v2
detmatriz = det(matriz)
submatriz = matriz([1 3],[2 3])
matrizunos2x2=ones(2);
submatrizmas1=submatriz+matrizunos2x2
detsubmatrizmas1=det(submatrizmas1)
invsubmatrizmas1=inv(submatrizmas1)
maxvalinvmatriz= max(invsubmatrizmas1)
PosMaxval= find(invsubmatrizmas1==maxvalinvmatriz)
PosValNoZero = find(invsubmatrizmas1)
sumcol=sum(invsubmatrizmas1,1)
sunfil=sum(invsubmatrizmas1,2)
save "MatrizInversaEj1.dat" invsubmatrizmas1

