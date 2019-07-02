ocorrencias([], _, 0).
ocorrencias([H|T], X, N) :- ocorrencias(T, X, Ct), (X = H -> N is Ct+1 ; N is Ct).

% ?- ocorrencias([1, 2, 3, 4, 3, 2, 1], 1, X).
% X = 2.

% ?- ocorrencias([1, 2, 3, 4, 3, 2, 1], 4, X).
% X = 1.