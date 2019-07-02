delta(A, B, C, D) :- V is B*B, T is 4*A*C, D is V-T.
eqSegundoGrau(A, B, C, ValorX) :- Div is 2*A, delta(A, B, C, D), Sq is sqrt(D), Bm is -B, Divn is Bm+Sq, ValorX is Divn/Div.

% ?- eqSegundoGrau(1, 2, -1, X).
% X = 0.41421356237309515.

% ?- eqSegundoGrau(1, -10, 24, X).
% X = 6.0.