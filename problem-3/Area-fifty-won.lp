% Problem 3 from the ICLP 2024 Programming Contest, organized by Prof. Martin Gebser

% Task title: Area fifty won
 
% Soulution by: Martin Gebser

diff(0,1;0,-1;1,0;-1,0).

{area(X,Y,XX,YY) : cell(XX,YY,0)} = N-1 :- cell(X,Y,N), 0 < N.
:- cell(XX,YY,0), #count{X,Y : area(X,Y,XX,YY)} != 1.

reach(X,Y,X,Y)   :- cell(X,Y,N), 0 < N.
reach(X,Y,X2,Y2) :- area(X,Y,X2,Y2), reach(X,Y,X1,Y1), diff(DX,DY), X2 = X1+DX, Y2 = Y1+DY.
:- area(X,Y,XX,YY), not reach(X,Y,XX,YY).

#show area/4.
#show area(X,Y,X,Y) : reach(X,Y,X,Y).
