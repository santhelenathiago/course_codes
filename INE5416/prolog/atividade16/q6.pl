menor([H], H) :- !.
menor([H|T],X) :- menor(T, MTail), (MTail < H -> X is MTail ; X is H).

% ?- menor([2, 3, 4, 5, 0], M).
% M = 0.

% ?- menor([2, 3, 4, 5], M).
% M = 2.