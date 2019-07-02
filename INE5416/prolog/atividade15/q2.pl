estuda(dan, ine5417).
estuda(dan, ine5413).
estuda(dan, ine5416).

estuda(bob, ine5417).
estuda(bob, ine5413).
estuda(bob, ine5416).
estuda(bob, ine5518).

estuda(john, ine5413).
estuda(john, ine5416).

estuda(carl, ine5413).
estuda(carl, ine5416).

estuda(carlos, ine5414).

leciona(jorge, ine5413). 
leciona(jorge, ine5310).
leciona(eminem, ine5416). 
leciona(bobEsponja, ine5417).
leciona(modem, ine5414).
leciona(ed, ine5518).

amigo(dan, john).
amigo(dan, carl).

amigo(john, bob).
amigo(john, carlos).

% ?- amigos(bob, john).
% true.

% ?- amigos(john, bob).
% true .

% ?- amigos(bob, jorge).
% false.
amigos(X, Y) :- amigo(X, Y) ; amigo(Y, X).

% ?- ensina(jorge, john)
% |    .
% true.

% ?- ensina(jorge, dan).
% true .

% ?- ensina(bobEsponja, dan).
% true.

% ?- ensina(bobEsponja, john).
% false.
ensina(X, Y) :- leciona(X, Materia), estuda(Y, Materia).

% ?- colegas(john, carlos).
% false.

% ?- colegas(john, dan).
% true .
colegas(X, Y) :- estuda(X, Materia), estuda(Y, Materia).


% encontrar todos as materias de um professor:
% ?- leciona(jorge, X).

% encontrar alunos de um professor
% ensina(jorge, X).

% econtrar amigos de um estudante
% amigos(john, X).