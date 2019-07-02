primeiros(0,_,[]) :- !.
primeiros(N, [H|T], L2) :- Nm1 is N-1, primeiros(Nm1, T, L2m), L2 = [H|L2m].

% ?- primeiros(2, [1, 2, 3], L).
% L = [1, 2].

% ?- primeiros(1, [1, 2, 3], L).
% L = [1].