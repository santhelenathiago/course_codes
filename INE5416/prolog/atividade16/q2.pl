inserirElementoPosicao(X, 0, L1, L2) :- append([X], L1, L2), !.
inserirElementoPosicao(X, P, [H|T], L2) :- 
        Pm1 is P-1, 
        inserirElementoPosicao(X, Pm1, T, L2rec),
        append([H], L2rec, L2).


% ?- inserirElementoPosicao(3, 1, [1, 2, 3], L).
% L = [1, 3, 2, 3].

% ?- inserirElementoPosicao(3, 2, [1, 2, 3], L).
% L = [1, 2, 3, 3].

% ?- inserirElementoPosicao(3, 0, [1, 2, 3], L).
% L = [3, 1, 2, 3].