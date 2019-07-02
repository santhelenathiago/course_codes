areaTriangulo(B, A, Area) :- M is B*A, Area is M/2.

% ?- areaTriangulo(2, 6, X).
% X = 6.

% ?- areaTriangulo(15, 12, X).
% X = 90.

% ?- areaTriangulo(15, 13, X).
% X = 97.5.