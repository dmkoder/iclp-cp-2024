% Problem 2 from the ICLP 2024 Programming Contest, organized by Prof. Martin Gebser
% Task title: Tile-them-all
% Soulution by: Martin Gebser

#const n=3.

pair(N,N..n) :- N = 0..n.

diff(0,1;1,0).

{tile(X1,Y1,X2,Y2)} :- cell(X1,Y1,N1), cell(X2,Y2,N2), diff(DX,DY), X2 = X1+DX, Y2 = Y1+DY.
 tile(X2,Y2,X1,Y1)  :- tile(X1,Y1,X2,Y2), (X1,Y1) < (X2,Y2).
:- cell(X1,Y1,N1), #count{X2,Y2 : tile(X1,Y1,X2,Y2)} != 1.

good(N1,N2) :- tile(X1,Y1,X2,Y2), cell(X1,Y1,N1), cell(X2,Y2,N2), (N1,X1,Y1) < (N2,X2,Y2).
:- pair(N1,N2), not good(N1,N2).

#show tile/4.
