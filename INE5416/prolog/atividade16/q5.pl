soma([],0).
soma([H|T], X) :- soma(T, Xac), X is H+Xac.

comprimento([], 0).
comprimento([_|T], C) :- comprimento(T, Cr), C is Cr+1.

media([], 0) :- !.
media(L,X) :- soma(L, Soma), comprimento(L, Comprimento), X is Soma/Comprimento.

% ?- media([], M).
% M = 0.

% ?- media([1, 2, 3], M).
% M = 2.