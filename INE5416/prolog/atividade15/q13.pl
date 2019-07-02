last(X,[X]).
last(X,[_|Z]) :- last(X,Z).

maior(A, B, C, X) :- sort([A, B, C], Ol), last(X, Ol).

% ?- maior(2, 1, 3, M).
% M = 3 .

% ?- maior(12, 4, 5, M).
% M = 12 .