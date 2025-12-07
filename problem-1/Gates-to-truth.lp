% Problem 1 from the ICLP 2024 Programming Contest, organized by Prof. Martin Gebser

% Task title: Gates to truth
 
% Soulution by: Martin Gebser

gate(G) :- unary(G).
gate(G) :- binary(G).

{function(G,0)} :- gate(G).
 function(G,1)  :- gate(G), not function(G,0).

propagate(F,X,V) :- entry(F,X,V).
propagate(F,O,V) :- output(G,O), function(G,B), input(G,1,I), unary(G),
                    propagate(F,I,W), V = |B-W|.
propagate(F,O,B) :- output(G,O), function(G,B), input(G,N,I), binary(G),
                    propagate(F,I,B).
propagate(F,O,B) :- output(G,O), function(G,1-B), input(G,1,I1), input(G,2,I2),
                    propagate(F,I1,B), propagate(F,I2,B).
:- value(F,O,V), not propagate(F,O,V).

#show function/2.
% #show propagate/3.
