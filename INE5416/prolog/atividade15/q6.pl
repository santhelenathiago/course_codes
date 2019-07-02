potencia(_, 0, 1).
potencia(X, Y, Resultado) :- Ym1 is Y-1, potencia(X, Ym1, R), Resultado is X*R.

% ?- potencia(2, 0, R).
% R = 1 .

% ?- potencia(3, 0, R).
% R = 1 .

% ?- potencia(3, 3, R).
% R = 27 .