ocorrencias([], _, 0).
ocorrencias([H|T], X, N) :-
    ocorrencias(T, X, Ct),
    (   X=H
    ->  N is Ct+1
    ;   N is Ct
    ).

membro(X, [X|_]) :-
    !.
membro(X, [_|T]) :-
    membro(X, T).

repetidos(L1, N, L2) :-
    repetidos_aux(L1, L1, N, L2).
repetidos_aux([], _, _, []).
repetidos_aux([H|T], L1c, N, L2) :-
    ocorrencias(L1c, H, Oc),
    repetidos_aux(T, L1c, N, L2_inc),
    (   Oc=<N,
        not(membro(H, L2_inc))
    ->  L2=[H|L2_inc]
    ;   L2=L2_inc
    ).
