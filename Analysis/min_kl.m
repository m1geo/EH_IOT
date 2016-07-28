function [ kltemp ] = min_kl(x, txta)
    
    global pshist
    global xvar
    
    %[pshist xvar]= hist(inputdata,200);
    
    %% NORMALS
    %[gain, mu, sig]
     a = [x(1) x(2) x(3)];
     b = [x(4) x(5) x(6)];
     c = [x(7) x(8) x(9)];
     d = [x(10) x(11) x(12)];
     kltemp = normals(a, b, c, d, xvar, pshist, 1, txta);
%     
%     %% EXPONENTIALS
%     %[gain, mu]
%    a = [x(1) x(2)];
%    b = [0 0];%[x(3) x(4)];
%    c = [0 0];%[x(5) x(6)];
%    kltemp = exponentials(a, b, c, xvar, pshist, 0);
    
    %% POISSONIAN
    %[gain, LAMBDA]
%    a = [x(1) x(2)];
%    b = [x(3) x(4)];
%    c = [x(5) x(6)];
%    kltemp = possi(a, b, c, xvar, pshist, 0);
end
