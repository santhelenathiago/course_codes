aprovado(A,B,C) :- Soma is A+B+C, Nota is Soma/3, Nota >= 6.

% ?- aprovado(6, 6, 6).
% true.

% ?- aprovado(6, 6, 5).
% false.

% ?- aprovado(6, 6.6, 5).
% false.

% ?- aprovado(6, 6.6, 5.5).
% true.