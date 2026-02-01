% Problem 1 from the ICLP 2024 Programming Contest, organized by Prof. Martin Gebser
% Task title: Gates to truth
% Soulution by: Martin Gebser

% gate are
gate(G) :- unary(G).
gate(G) :- binary(G).

% Function of any gate can be chosen to be 0
{function(G,0)} :- gate(G).
% All other gates have function 1
 function(G,1)  :- gate(G), not function(G,0).

% Propagate agrees with the given entries
propagate(F,X,V) :- entry(F,X,V).

% Propagate for unary gates
propagate(F,O,V) :- output(G,O), function(G,B), input(G,1,I), unary(G),
                    propagate(F,I,W), V = |B-W|.

% Propagate of binary gates when one input has absorbing value
propagate(F,O,B) :- output(G,O), function(G,B), input(G,N,I), binary(G),
                    propagate(F,I,B).

% Propagate of binary gates when there are no absorbing values
propagate(F,O,B) :- output(G,O), function(G,1-B), input(G,1,I1), input(G,2,I2),
                    propagate(F,I1,B), propagate(F,I2,B).

% The output and the propagated values match
:- value(F,O,V), not propagate(F,O,V).

#show function/2.
% #show propagate/3.
