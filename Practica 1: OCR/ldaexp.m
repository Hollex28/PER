#!/usr/bin/octave -qf


if (nargin != 8)
    printf("Usage: pcaexp.m <trdata> <trlabels> <tedata> <telabels> <mink> <stepk> <maxk> <pausa>\n");
    exit(1);
end

# Procesamiento de argumentos
arg_list = argv();
trdata   = arg_list{1};
trlabels = arg_list{2};
tedata   = arg_list{3};
telabels = arg_list{4};
mink     = str2num(arg_list{5})
stepk    = str2num(arg_list{6});
maxk     = str2num(arg_list{7});
pausa	 = str2num(arg_list{8});

# Carga de datos
load(trdata);
load(trlabels);
load(tedata);
load(telabels);

[W] = lda(X,xl);
kn = knn(X,xl,Y,yl,1);
Kvect = [];
ErrVect = [];
for k = mink:stepk:maxk
    Xr = W(:, 1:k)' * (X);
    Yr = W(:, 1:k)' * (Y);
    err = knn(Xr, xl, Yr, yl, 1);
    printf("%d %f\n", k, err);
	Kvect = [Kvect k];
	ErrVect = [ErrVect err];
endfor

plot(Kvect,ErrVect,'g');
hold();
plot([10,100],[kn,kn]);
pause(pausa);
