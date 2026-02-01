% Problem 2 from the ICLP 2024 Programming Contest, organized by Prof. Martin Gebser
% Task title: Tile-them-all
% Solution by: Martin Gebser

#const n=3.

% All possible pairs
pair(N,N..n) :- N = 0..n.

% Different predicate
diff(0,1;1,0).

% Two neighboring cells can be chosen to be in a tile
{tile(X1,Y1,X2,Y2)} :- cell(X1,Y1,N1), cell(X2,Y2,N2), diff(DX,DY), X2 = X1+DX, Y2 = Y1+DY.
% Tile is symmetric
 tile(X2,Y2,X1,Y1)  :- tile(X1,Y1,X2,Y2), (X1,Y1) < (X2,Y2).
% Each tile has exactly two cells
:- cell(X1,Y1,N1), #count{X2,Y2 : tile(X1,Y1,X2,Y2)} != 1.

% The pairs (ordered, so no symmetric) captured by any tile
good(N1,N2) :- tile(X1,Y1,X2,Y2), cell(X1,Y1,N1), cell(X2,Y2,N2), (N1,X1,Y1) < (N2,X2,Y2).

% All pairs have to be captured
:- pair(N1,N2), not good(N1,N2).

#show tile/4.
