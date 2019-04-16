#!/usr/bin/octave -qf

if (nargin != 11)
    printf("Usage: pcaldaexp.m <trdata> <trlabels> <tedata> <telabels> <mink> <stepk> <maxk> <mink> <stepk> <maxk> <pausa>\n");
    exit(1);
end

arg_list = argv();
trdata   = arg_list{1};
trlabels = arg_list{2};
tedata   = arg_list{3};
telabels = arg_list{4};
pmink     = str2num(arg_list{5});
pstepk    = str2num(arg_list{6});
pmaxk     = str2num(arg_list{7});
lmink     = str2num(arg_list{8});
lstepk    = str2num(arg_list{9});
lmaxk     = str2num(arg_list{10});
pausa     = str2num(arg_list{11});

load(trdata);
load(trlabels);
load(tedata);
load(telabels);

[m, W] = pca(X, pmaxk);
for kp = pmink:pstepk:pmaxk
    Xr = W(:, 1:kp)' * (X - m);
    Yr = W(:, 1:kp)' * (Y - m);
    err = knn(Xr, xl, Yr, yl, 1);
    
    


Wl = lda(Xr, xl, lmaxk);
for kl = lmink:lstepk:lmaxk
    Xrl = Wl(:, 1:kl)' * Xr;
    Yrl = Wl(:, 1:kl)' * Yr;
    err = knn(Xrl, xl, Yrl, yl, 1);
    printf("%d\t%d\t%.3f\n", kp,kl, err);
    	%Kvect = [Kvect kl];
	%ErrVect = [ErrVect err];
	end
end
%plot(Kvect,ErrVect,'g');
%hold();
%plot([10,100],[kn,kn]);
%pause(pausa);
%exit
