function [W]=lda(X,xl)
    n = columns(X);
	Dim = rows(X);
    media = sum(X')'/n;#media global de los datos
	#inicializacion sb sw
	sb = zeros(Dim);
	sw = sb;
	k=256;

	#Para cada clase c:
    for c=unique(xl)
		elementoc = find (xl == c);
        nc = columns(elementoc);
        xc = sum(X(:,elementoc)')' / nc;
		sw = sw + ((X(:,elementoc) - xc) * (X(:,elementoc) - xc)' / nc);
        sb = sb + (nc * (xc - media) * (xc - media)');
    endfor
	
    [V, lambda] = eig(sb, sw);
    [eigval, order] = sort(-diag(lambda)');
    W = V(:,order)(:,1:k);

endfunction
