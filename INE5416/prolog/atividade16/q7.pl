ultimo([H], H) :- !.
ultimo([_|T], L) :- ultimo(T, L).

menosUltimo([_], []) :- !.
menosUltimo([H|T], L) :- menosUltimo(T, L1), L = [H | L1].

palindrome([_]) :- true, !.
palindrome([]) :- true, !.
palindrome([H|T]) :- ultimo(T, L), H = L, menosUltimo(T, TmU), palindrome(TmU).

% ?- palindrome([1, 2, 3, 4, 3, 2]).
% false.

% ?- palindrome([1, 2, 3, 4, 3, 2, 1]).
% true.