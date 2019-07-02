membro(X, [X|_]) :-
    !.
membro(X, [_|T]) :-
    membro(X, T).

quantasListasTemOElemento(_, [], 0) :-
    !. 
quantasListasTemOElemento(E, [H|T], C) :-
    quantasListasTemOElemento(E, T, C_inc),
    (   membro(E, H)
    ->  C is C_inc+1
    ;   C is C_inc
    ).

elementsFromLists(L1, L2) :-
    flatten(L1, La),
    list_to_set(La, L2).

elementoQueMaisSeRepete([H], _, H).

elementoQueMaisSeRepete([H|T], ListaDeListas, X) :-
    elementoQueMaisSeRepete(T, ListaDeListas, X_inc),
    quantasListasTemOElemento(H, ListaDeListas, QntH),
    quantasListasTemOElemento(X_inc, ListaDeListas, QntX_inc),
    (   QntH>QntX_inc
    ->  X=H
    ;   X=X_inc
    ).

maisPresencas(L, X) :-
    elementsFromLists(L, Valores),
    elementoQueMaisSeRepete(Valores, L, X).