trianguloc(A, B, C) :- Subn is B-C,
                       abs(Subn, Sub),
                       Sum is B+C,
                       Sub < A, A < Sum.
triangulo(X, Y, Z) :- trianguloc(X, Y, Z),
                      trianguloc(Y, X, Z),
                      trianguloc(Z, X, Y).

% ?- triangulo(10, 14, 8).
% true.

% ?- triangulo(10, 14, 1).
% false.

% ?- triangulo(10, 14, 12).
% true.