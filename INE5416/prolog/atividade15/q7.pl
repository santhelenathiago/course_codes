absoluto(N, X) :- N < 0 -> X is -N; X is N. 

% ?- absoluto(-1, X).
% X = 1.

% ?- absoluto(-12, X).
% X = 12.

% ?- absoluto(12, X).
% X = 12.