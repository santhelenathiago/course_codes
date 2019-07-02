:- dynamic fib/2.
:- retractall( fib(_,_) ).

fib(0, 0) :- !.
fib(1, 1) :- !.
fib(N, K) :-
    N1 is N-1,
    N2 is N-2,
    fib(N1, K1),
    fib(N2, K2),
    K is K1+K2,
    asserta(fib(N2, K2) :- !),
    asserta(fib(N1, K1) :- !).