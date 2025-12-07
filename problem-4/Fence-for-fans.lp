% Problem 4 from the ICLP 2024 Programming Contest, organized by Prof. Martin Gebser

% Task title: Fence for fans
 
% Soulution by: Martin Gebser

#const inner = 0.
#const point = 1.

diff(0,1;0,-1;1,0;-1,0).

empty :- length(L), L < 4. % can be skipped if using budget only

guess(X,Y,C) :- reward(X,Y,R), cost(X,Y,C), budget(B), 0 <= R, C <= B, not empty.

{fence(X,Y)} :- guess(X,Y,C).
:- length(L), #count{X,Y : fence(X,Y)} > L. % can be skipped if using budget only
:- budget(B), #sum+{C,X,Y : fence(X,Y), cost(X,Y,C)} > B.

connect(X1,Y1,X2,Y2) :- guess(X1,Y1,C), fence(X2,Y2), diff(X,Y), X2 = X1+X, Y2 = Y1+Y.
:- fence(X1,Y1), #count{X2,Y2 : connect(X1,Y1,X2,Y2)} != 2.

score(X,Y,C)   :- guess(X,Y,C), C != 0, not reward(X,Y,_).
score(X,Y,C-R) :- guess(X,Y,C), reward(X,Y,R), C != R.

start(X,Y,R) :- score(X,Y,-R), 0 < R.

index(X,Y,I) :- start(X,Y,R), I = #count{RR,XX,YY : start(XX,YY,RR), (RR,XX,YY) < (R,X,Y)}.

other(I-1) :- index(X,Y,I), fence(X,Y), 0 < I.
other(I-1) :- other(I), 0 < I.

reach(X,Y) :- index(X,Y,I), fence(X,Y), not other(I).
reach(X,Y) :- reach(XX,YY), connect(XX,YY,X,Y).
:- fence(X,Y), not reach(X,Y).

fence :- fence(X,Y), point = 1.

single(X,Y,C,I) :- score(X,Y,C), index(X,Y,I), not index(_,_,I+1), not fence, point = 1.

:~ fence(X,Y), score(X,Y,C). [C,X,Y]
:~ single(X,Y,C,I). [C]

outside(X,Y)   :- width(W), height(H), X = (1;W), Y = 1..H, inner != 0.
outside(X,Y)   :- width(W), height(H), X = 1..W, Y = (1;H), inner != 0.
outside(X2,Y2) :- width(W), height(H), diff(X,Y), outside(X1,Y1), not fence(X1,Y1),
                  X2 = X1+X, Y2 = Y1+Y, 0 < X2, X2 <= W, 0 < Y2, Y2 <= H.

:~ reward(X,Y,R), not outside(X,Y), not fence(X,Y), inner != 0. [-R,X,Y]

unique(X,Y,C,I) :- single(X,Y,C,I).
unique(X,Y,C,I) :- score(X,Y,C), index(X,Y,I), unique(XX,YY,C,I+1).

#show fence/2.
#show unique(X,Y) : unique(X,Y,C,I).

% CALL: clingo instances/instance01.lp encodings/encoding.lp --opt-mode=optN --quiet=1,1
%*
clingo version 5.7.2 (332b52b)
Reading from instances/instance01.lp ...
Solving...
Answer: 1
fence(8,2) fence(9,2) fence(8,3) fence(9,3)
Optimization: -6
Answer: 2
fence(1,1) fence(2,1) fence(1,2) fence(2,2)
Optimization: -6
Answer: 3
fence(1,2) fence(2,2) fence(3,2) fence(1,3) fence(3,3) fence(1,4) fence(2,4) fence(3,4)
Optimization: -6
Answer: 4
fence(2,2) fence(3,2) fence(2,3) fence(3,3)
Optimization: -6
OPTIMUM FOUND
*%

% CALL: clingo instances/instance01.lp encodings/encoding.lp --opt-mode=optN --quiet=1,1 --const inner=1
%*
clingo version 5.7.2 (332b52b)
Reading from instances/instance01.lp ...
Solving...
Answer: 1
fence(1,1) fence(2,1) fence(3,1) fence(1,2) fence(3,2) fence(1,3) fence(3,3) fence(1,4) fence(2,4) fence(3,4)
Optimization: -8
OPTIMUM FOUND
*%
