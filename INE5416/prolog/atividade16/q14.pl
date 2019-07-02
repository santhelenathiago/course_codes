membro(_, []) :- false.
membro(X,[X|_]) :- !.
membro(X,[_|T]) :- membro(X,T).

concatena([],L,L).
concatena([H|T],L2,[H|LContatenada]) :- concatena(T,L2,LContatenada).

listaParaConjunto([],[]).
listaParaConjunto([H|T],[H|L]):- not(membro(H,T)), listaParaConjunto(T,L).
listaParaConjunto([H|T],L):- membro(H,T), listaParaConjunto(T,L).

uniao(S1, S2, S3) :- concatena(S1, S2, SS3), listaParaConjunto(SS3, S3).

% ?- uniao([1, 2, 3, 5], [2, 3, 4], L).
% L = [1, 5, 2, 3, 4] .