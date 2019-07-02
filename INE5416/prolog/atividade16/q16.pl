membro(X,[X|_]) :- !.
membro(X,[_|T]) :- membro(X,T).

interseccao([], _, []) :- !.
interseccao([H|T], S2, S3) :- membro(H, S2) ->
                                    interseccao(T, S2, SS3), S3 = [H|SS3]
                              ;
                                    interseccao(T, S2, S3).


diferenca([], _, []).
diferenca([H|T], S2, S3) :- membro(H, S2) ->
                            diferenca(T, S2, S3) 
                        ;
                            diferenca(T, S2, SS3), S3 = [H|SS3].


concatena([],L,L).
concatena([H|T],L2,[H|LContatenada]) :- concatena(T,L2,LContatenada).
                                                    
listaParaConjunto([],[]).
listaParaConjunto([H|T],[H|L]):- not(membro(H,T)), listaParaConjunto(T,L).
listaParaConjunto([H|T],L):- membro(H,T), listaParaConjunto(T,L).

uniao(S1, S2, S3) :- concatena(S1, S2, SS3), listaParaConjunto(SS3, S3).

uniao(S1, S2, S3, S4) :- uniao(S1, S2, SS3), uniao(SS3, S3, S4).
interseccao(S1, S2, S3, S4) :- interseccao(S1, S2, SS3), interseccao(SS3, S3, S4).
diferenca(S1, S2, S3, S4) :- diferenca(S1, S2, SS3), diferenca(SS3, S3, S4).


% ?- interseccao([1, 2, 3, 5], [2, 3, 4], [2, 6, 7], L).
% L = [2].

% ?- uniao([1, 2, 3, 5], [2, 3, 4], [2, 6, 7], L).
% L = [1, 5, 3, 4, 2, 6, 7] .

% ?- diferenca([1, 2, 3, 5], [2, 3, 4], [2, 6, 7], L).
% L = [1, 5].