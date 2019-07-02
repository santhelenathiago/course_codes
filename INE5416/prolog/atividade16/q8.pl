menor([H], H) :- !.
menor([H|T],X) :- menor(T, MTail), (MTail < H -> X is MTail ; X is H).

maior([H], H) :- !.
maior([H|T],X) :- maior(T, MTail), (MTail > H -> X is MTail ; X is H).


diferencaMaiorMenor(L,X) :- maior(L, Maior), menor(L, Menor), X is Maior-Menor.


% ?- diferencaMaiorMenor([1, 2, 3, 4], M).
% M = 3.

% ?- diferencaMaiorMenor([1, 2, 3, 4, 321], M).
% M = 320.