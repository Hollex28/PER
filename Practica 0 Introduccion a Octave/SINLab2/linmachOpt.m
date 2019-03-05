function cstar=linmachOpt(w,x)
	g=w'*x;
	c = find(g(:,end)==max(g));
	cstar=c;
endfunction
