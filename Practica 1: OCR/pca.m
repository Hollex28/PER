function [m,W]=pca(X)
    Ncolumnas = columns(X);#lo mismo que Dim(x)
    m = mean(X')';#vector media de las columnas de la matriz
    #Calcular matriz de covalianza
    A = X - m;
    MCovarianza = (1/Ncolumnas)*A*A';
    #valores propios de la matriz 
    [eigvec,eigval]=eig(MCovarianza);
    #esto ordena los eigval de mayor a menor
    [eigvalord,I]=sort(diag(eigval),'descend');
    #se retornan los eigvectores
    W = eigvec (:,I);
endfunction