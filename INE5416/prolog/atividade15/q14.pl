operacao(+, X, Y, Resultado) :- Resultado is X+Y.
operacao(-, X, Y, Resultado) :- Resultado is X-Y.
operacao(*, X, Y, Resultado) :- Resultado is X*Y.
operacao(/, X, Y, Resultado) :- Resultado is X/Y.

% ?- operacao(+, 1, 2, R).
% R = 3.

% ?- operacao(*, 1, 2, R).
% R = 2.

% ?- operacao(/, 5, 2, R).
% R = 2.5.

% ?- operacao(-, 5, 2, R).
% R = 3.
