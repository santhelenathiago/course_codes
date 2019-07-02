comprimento([],0).
comprimento([_|T],C) :- comprimento(T,CT), C is CT + 1.

primeiros(0,_,[]) :- !.
primeiros(N, [H|T], L2) :- Nm1 is N-1, primeiros(Nm1, T, L2m), L2 = [H|L2m].

apagar(0, L1, L1) :- !.
apagar(N, [_|T], L2) :- Nm1 is N-1, apagar(Nm1, T, L2).

dividir(L1,L2,L3) :- comprimento(L1, C1),
                     CL3 is div(C1, 2),
                     CL2 is C1-CL3,
                     primeiros(CL2, L1, L2),
                     apagar(CL2, L1, L3).

% ?- dividir([1, 2 , 3, 4], L2, L3).
% L2 = [1, 2],
% L3 = [3, 4].

% ?- dividir([1, 2 , 3, 4, 5], L2, L3).
% L2 = [1, 2, 3],
% L3 = [4, 5].