
inverter([H], [H]) :- !.
inverter(L1, L2) :- ultimo(L1, U), menosUltimo(L1, MU), inverter(MU, MLU), L2 = [U | MLU].

ultimo([H], H) :- !.
ultimo([_|T], L) :- ultimo(T, L).

menosUltimo([_], []) :- !.
menosUltimo([H|T], L) :- menosUltimo(T, L1), L = [H | L1].


% ?- inverter([1, 2, 3, 4], X).
% X = [4, 3, 2, 1].