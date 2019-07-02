posicao(X,[X|_],P) :- P is 0, !.
posicao(X,[_|T],P) :- posicao(X, T, P1), P is P1+1.

% ?- posicao(1, [1, 2, 3, 4], P).
% P = 0.

% ?- posicao(2, [1, 2, 3, 4], P).
% P = 1.

% ?- posicao(3, [1, 2, 3, 4], P).
% P = 2.

% ?- posicao(4, [1, 2, 3, 4], P).
% P = 3.