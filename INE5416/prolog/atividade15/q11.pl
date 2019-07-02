fib(0, 0).
fib(1, 1).
fib(N, K) :- Nm1 is N-1, Nm2 is N-2, fib(Nm1, FNm1), fib(Nm2, FNm2), K is FNm1+FNm2.

% ?- fib(0, K).
% K = 0 .

% ?- fib(1, K).
% K = 1 .

% ?- fib(2, K).
% K = 1 .

% ?- fib(3, K).
% K = 2 .

% ?- fib(4, K).
% K = 3 .

% ?- fib(5, K).
% K = 5 .