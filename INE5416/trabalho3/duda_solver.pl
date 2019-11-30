tabuleiro([
    [_,_,_,_,_,_],
    [_,_,_,_,_,_],
    [_,_,_,_,_,_],
    [_,_,_,_,_,_],
    [_,_,_,_,_,_],
    [_,_,_,_,_,_]
    ]).

numero(1).
numero(2).
numero(3).
numero(4).
numero(5).
numero(6).

completa([X1, X2, X3, X4, X5, X6]) :- numero(X1), numero(X2), numero(X3), numero(X4), numero(X5), numero(X6),
                todosDiferentes([X1,X2,X3,X4,X5,X6]).

% ---------------------------------------------- VERIFICAR SIMBOLOS

% ---------------------------------------------- RIGHT

verificar_simbolos_dir(_, _, Tamanho, Tamanho).

verificar_simbolos_dir(Quadrado, [2|T], Index, Tamanho) :-
    NextIndex is Index+1,
    verificar_simbolos_dir(Quadrado, T, NextIndex, Tamanho).

verificar_simbolos_dir(Quadrado, [0|T], Index, Tamanho) :-
    nth0(Index,Quadrado,E1), numero(E1),
    SearchIndex is Index+1,
    nth0(SearchIndex,Quadrado,E2), numero(E2),
    E1 > E2,
    NextIndex is Index+1,
    verificar_simbolos_dir(Quadrado,T,NextIndex,Tamanho).

verificar_simbolos_dir(Quadrado, [1|T], Index, Tamanho) :-
    nth0(Index,Quadrado,E1), numero(E1),
    SearchIndex is Index+1,
    nth0(SearchIndex,Quadrado,E2), numero(E2),
    E1 < E2,
    NextIndex is Index+1,
    verificar_simbolos_dir(Quadrado,T,NextIndex,Tamanho).

% ---------------------------------------------- LEFT

verificar_simbolos_esq(_, _, Tamanho, Tamanho).

verificar_simbolos_esq(Quadrado, [2|T], Index, Tamanho) :-
    NextIndex is Index+1,
    verificar_simbolos_esq(Quadrado, T, NextIndex, Tamanho).

verificar_simbolos_esq(Quadrado, [0|T], Index, Tamanho) :-
    nth0(Index,Quadrado,E1), numero(E1),
    SearchIndex is Index-1,
    nth0(SearchIndex,Quadrado,E2), numero(E2),
    E1 > E2,
    NextIndex is Index+1,
    verificar_simbolos_esq(Quadrado,T,NextIndex,Tamanho).

verificar_simbolos_esq(Quadrado, [1|T], Index, Tamanho) :-
    nth0(Index,Quadrado,E1), numero(E1),
    SearchIndex is Index-1,
    nth0(SearchIndex,Quadrado,E2), numero(E2),
    E1 < E2,
    NextIndex is Index+1,
    verificar_simbolos_esq(Quadrado,T,NextIndex,Tamanho).

% ---------------------------------------------- BOTTOM

verificar_simbolos_baixo(_, _, Tamanho, Tamanho).

verificar_simbolos_baixo(Quadrado, [2|T], Index, Tamanho) :-
    NextIndex is Index+1,
    verificar_simbolos_baixo(Quadrado, T, NextIndex, Tamanho).

verificar_simbolos_baixo(Quadrado, [0|T], Index, Tamanho) :-
    nth0(Index,Quadrado,E1), numero(E1),
    SearchIndex is Index+2,
    nth0(SearchIndex,Quadrado,E2), numero(E2),
    E1 > E2,
    NextIndex is Index+1,
    verificar_simbolos_baixo(Quadrado,T,NextIndex,Tamanho).

verificar_simbolos_baixo(Quadrado, [1|T], Index, Tamanho) :-
    nth0(Index,Quadrado,E1), numero(E1),
    SearchIndex is Index+2,
    nth0(SearchIndex,Quadrado,E2), numero(E2),
    E1 < E2,
    NextIndex is Index+1,
    verificar_simbolos_baixo(Quadrado,T,NextIndex,Tamanho).

% ---------------------------------------------- TOP


verificar_simbolos_cima(_, _, Tamanho, Tamanho).

verificar_simbolos_cima(Quadrado, [2|T], Index, Tamanho) :-
    NextIndex is Index+1,
    verificar_simbolos_cima(Quadrado, T, NextIndex, Tamanho).

verificar_simbolos_cima(Quadrado, [0|T], Index, Tamanho) :-
    nth0(Index,Quadrado,E1), numero(E1),
    SearchIndex is Index-2,
    nth0(SearchIndex,Quadrado,E2), numero(E2),
    E1 > E2,
    NextIndex is Index+1,
    verificar_simbolos_cima(Quadrado,T,NextIndex,Tamanho).

verificar_simbolos_cima(Quadrado, [1|T], Index, Tamanho) :-
    nth0(Index,Quadrado,E1), numero(E1),
    SearchIndex is Index-2,
    nth0(SearchIndex,Quadrado,E2), numero(E2),
    E1 < E2,
    NextIndex is Index+1,
    verificar_simbolos_cima(Quadrado,T,NextIndex,Tamanho).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)),
                todosDiferentes(T).

% ---------------------------------------------- SOLVING

solucao6x6(TabuleiroSolucao) :-TabuleiroSolucao =
    tabuleiro([
            [X11, X12, X13, X14, X15, X16],
            [X21, X22, X23, X24, X25, X26],
            [X31, X32, X33, X34, X35, X36],
            [X41, X42, X43, X44, X45, X46],
            [X51, X52, X53, X54, X55, X56],
            [X61, X62, X63, X64, X65, X66]]),

    verificar_simbolos_esq([X11, X12, X21, X22, X31, X32], [2,1,2,0,2,1], 0, 6),
    verificar_simbolos_esq([X13, X14, X23, X24, X33, X34], [2,0,2,1,2,0], 0, 6),
    verificar_simbolos_esq([X15, X16, X25, X26, X35, X36], [2,1,2,1,2,1], 0, 6),
    verificar_simbolos_esq([X41, X42, X51, X52, X61, X62], [2,0,2,0,2,0], 0, 6),
    verificar_simbolos_esq([X43, X44, X53, X54, X63, X64], [2,1,2,1,2,0], 0, 6),
    verificar_simbolos_esq([X45, X46, X55, X56, X65, X66], [2,0,2,0,2,0], 0, 6),

    verificar_simbolos_dir([X11, X12, X21, X22, X31, X32], [0,2,1,2,0,2], 0, 6),
    verificar_simbolos_dir([X13, X14, X23, X24, X33, X34], [1,2,0,2,1,2], 0, 6),
    verificar_simbolos_dir([X15, X16, X25, X26, X35, X36], [0,2,0,2,0,2], 0, 6),
    verificar_simbolos_dir([X41, X42, X51, X52, X61, X62], [1,2,1,2,1,2], 0, 6),
    verificar_simbolos_dir([X43, X44, X53, X54, X63, X64], [0,2,0,2,1,2], 0, 6),
    verificar_simbolos_dir([X45, X46, X55, X56, X65, X66], [1,2,1,2,1,2], 0, 6),

    verificar_simbolos_baixo([X11, X12, X21, X22, X31, X32], [0,1,1,0,2,2], 0, 6),
    verificar_simbolos_baixo([X13, X14, X23, X24, X33, X34], [1,1,0,1,2,2], 0, 6),
    verificar_simbolos_baixo([X15, X16, X25, X26, X35, X36], [0,0,1,1,2,2], 0, 6),
    verificar_simbolos_baixo([X41, X42, X51, X52, X61, X62], [0,0,0,0,2,2], 0, 6),
    verificar_simbolos_baixo([X43, X44, X53, X54, X63, X64], [1,0,0,1,2,2], 0, 6),
    verificar_simbolos_baixo([X45, X46, X55, X56, X65, X66], [1,1,1,0,2,2], 0, 6),

    verificar_simbolos_cima([X11, X12, X21, X22, X31, X32], [2,2,1,0,0,1], 0, 6),
    verificar_simbolos_cima([X13, X14, X23, X24, X33, X34], [2,2,0,0,1,0], 0, 6),
    verificar_simbolos_cima([X15, X16, X25, X26, X35, X36], [2,2,1,1,0,0], 0, 6),
    verificar_simbolos_cima([X41, X42, X51, X52, X61, X62], [2,2,1,1,1,1], 0, 6),
    verificar_simbolos_cima([X43, X44, X53, X54, X63, X64], [2,2,0,1,1,0], 0, 6),
    verificar_simbolos_cima([X45, X46, X55, X56, X65, X66], [2,2,0,0,0,1], 0, 6),

    %Linhas
    completa([X11, X12, X13, X14, X15, X16]),
    completa([X21, X22, X23, X24, X25, X26]),
    completa([X31, X32, X33, X34, X35, X36]),
    completa([X41, X42, X43, X44, X45, X46]),
    completa([X51, X52, X53, X54, X55, X56]),
    completa([X61, X62, X63, X64, X65, X66]),

    %Colunas
    completa([X11, X21, X31, X41, X51, X61]),
    completa([X12, X22, X32, X42, X52, X62]),
    completa([X13, X23, X33, X43, X53, X63]),
    completa([X14, X24, X34, X44, X54, X64]),
    completa([X15, X25, X35, X45, X55, X65]),
    completa([X16, X26, X36, X46, X56, X66]),

    %quadrados menores
    completa([X11, X12, X21, X22, X31, X32]),
    completa([X13, X14, X23, X24, X33, X34]),
    completa([X15, X16, X25, X26, X35, X36]),
    completa([X41, X42, X51, X52, X61, X62]),
    completa([X43, X44, X53, X54, X63, X64]),
    completa([X45, X46, X55, X56, X65, X66]).