apagar(0, L1, L1) :- !.
apagar(N, [_|T], L2) :- Nm1 is N-1, apagar(Nm1, T, L2).

% ?- apagar(0, [1, 2 , 3], L).
% L = [1, 2, 3].

% ?- apagar(1, [1, 2 , 3], L).
% L = [2, 3].

% ?- apagar(2, [1, 2 , 3], L).
% L = [3].

% ?- apagar(3, [1, 2 , 3], L).
% L = [].