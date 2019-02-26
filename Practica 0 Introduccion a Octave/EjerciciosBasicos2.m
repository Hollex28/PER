#!/usr/bin/octave -qf


%if (nargin!=5)
% printf("Usage: ./experiment.m <data> <alphas> <bes> <K> <%%Tr>\n");
% exit(1);
%end

%arg_list=argv();
%data=arg_list{1};
%as=str2num(arg_list{2});

load "Datos/gender.gz"
size(data)
[fila,columna] = PrimeraFC(data);
transpuesta = data';
size(transpuesta)
save "data_trans.dat" transpuesta;
