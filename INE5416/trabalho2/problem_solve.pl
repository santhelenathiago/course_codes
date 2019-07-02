vela(amarela).
vela(azul).
vela(branca).
vela(verde).
vela(vermelha).

homem(caue).
homem(francisco).
homem(murilo).
homem(ronaldo).
homem(tulio).

mulher(andressa).
mulher(bianca).
mulher(daniela).
mulher(isabel).
mulher(lucia).

namoro(tresAnos).
namoro(quatroAnos).
namoro(cincoAnos).
namoro(seisAnos).
namoro(seteAnos).

macarrao(canelone).
macarrao(farfalle).
macarrao(fettuccine).
macarrao(espaguete).
macarrao(ravioli).

vinho(argentino).
vinho(chileno).
vinho(frances).
vinho(italiano).
vinho(portugues).

%X está à ao lado de Y
aoLado(X, Y, Lista) :-
    (   nextto(X, Y, Lista)
    ;   nextto(Y, X, Lista)
    ).

% X esta diretamente a direita de Y
diretamenteADireita(X, Y, Lista) :-
    nth0(IndexX, Lista, X),
    nth0(IndexY, Lista, Y),
    IndexXmightBe is IndexY+1,
    IndexX = IndexXmightBe.

% X esta diretamente a esquerda de Y
diretamenteAEsquerda(X, Y, Lista) :-
    diretamenteADireita(Y, X, Lista).

%X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X, Y, Lista) :-
    nth0(IndexX, Lista, X),
    nth0(IndexY, Lista, Y),
    IndexX<IndexY.
                        
%X está à direita de Y (em qualquer posição à direita)
aDireita(X, Y, Lista) :-
    aEsquerda(Y, X, Lista). 

%X está no canto se ele é o primeiro ou o último da lista
noCanto(X, Lista) :-
    last(Lista, X).
noCanto(X, [X|_]).

todosDiferentes([]).
todosDiferentes([H|T]) :-
    not(member(H, T)),
    todosDiferentes(T).

solve(ListaSolucao) :-
    ListaSolucao=[casal(Vela1, Homem1, Mulher1, Namoro1, Macarrao1, Vinho1), 
                  casal(Vela2, Homem2, Mulher2, Namoro2, Macarrao2, Vinho2), 
                  casal(Vela3, Homem3, Mulher3, Namoro3, Macarrao3, Vinho3), 
                  casal(Vela4, Homem4, Mulher4, Namoro4, Macarrao4, Vinho4), 
                  casal(Vela5, Homem5, Mulher5, Namoro5, Macarrao5, Vinho5)],

% O casal que está comendo Ravióli está na mesa com a vela Verde.
    member(casal(verde, _, _, _, ravioli, _),
           ListaSolucao),

% A mesa com a vela Azul está exatamente à direita do casal que está comendo Espaguete.
    diretamenteADireita(casal(azul, _, _, _, _, _), casal(_, _, _, _, espaguete, _), ListaSolucao),

% O casal que namora há 3 anos está em algum lugar entre o casal que está bebendo vinho Francês e o casal que namora há 6 anos, nessa ordem.
    aDireita(casal(_, _, _, tresAnos, _, _), casal(_, _, _, _, _, frances), ListaSolucao),
    aDireita(casal(_, _, _, seisAnos, _, _), casal(_, _, _, tresAnos, _, _), ListaSolucao),

% Andressa está exatamente à esquerda de Daniela.
    diretamenteAEsquerda(casal(_, _, andressa, _, _, _), casal(_, _, daniela, _, _, _), ListaSolucao),

% Francisco e a namorada dele estão na mesa com a vela Azul.
    member(casal(azul, francisco, _, _, _, _), ListaSolucao),

% Na segunda posição está o casal que está bebendo vinho do Porto.
    Vinho2 = portugues,

% Os namorados que estão comendo Fettuccine estão ao lado dos namorados que estão na mesa com a vela Branca.
    aoLado(casal(_, _, _, _, fettuccine, _), casal(branca, _, _, _, _, _), ListaSolucao),

% Murilo está em algum lugar entre o casal que está na mesa com a vela Vermelha e o Francisco, nessa ordem.
    aDireita(casal(_, murilo, _, _, _, _), casal(vermelha, _, _, _, _, _), ListaSolucao),
    aDireita(casal(_, francisco, _, _, _, _), casal(_, murilo, _, _, _, _), ListaSolucao),

% Isabel está ao lado dos namorados que estão juntos há 4 anos.
    aoLado(casal(_, _, isabel, _, _, _), casal(_, _, _, quatroAnos, _, _), ListaSolucao),

% O casal que está comendo Fettuccine está na mesa com a vela Azul.
    member(casal(azul, _, _, _, fettuccine, _), ListaSolucao),

% Francisco está ao lado dos namorados que estão bebendo vinho Argentino.
    aoLado(casal(_, francisco, _, _, _, _), casal(_, _, _, _, _, argentino), ListaSolucao),

% Cauê e a namorada dele estão na primeira ou na última mesa.
    noCanto(casal(_, caue, _, _, _, _), ListaSolucao),

% O casal que está comendo Farfalle está em algum lugar à direita do casal que está na mesa com a vela Azul.
    aDireita(casal(_, _, _, _, farfalle, _), casal(azul, _, _, _, _, _), ListaSolucao),

% Lúcia está ao lado dos namorados que estão comendo Ravióli.
    aoLado(casal(_, _, lucia, _, _, _), casal(_, _, _, _, ravioli, _), ListaSolucao),

% O casal que namora há 4 anos está na mesa com a vela Branca.
    member(casal(branca, _, _, quatroAnos, _, _), ListaSolucao),

% Túlio está exatamente à esquerda de Murilo.
    diretamenteAEsquerda(casal(_, tulio, _, _, _, _), casal(_, murilo, _, _, _, _), ListaSolucao),

% Em uma das pontas estão os namorados que estão comendo Ravióli.
    noCanto(casal(_, _, _, _, ravioli, _), ListaSolucao),

% O casal que namora há 4 anos está em algum lugar entre o casal que está na mesa com a vela Vermelha e o casal que namora há 7 anos, nessa ordem.
    aDireita(casal(_, _, _, quatroAnos, _, _), casal(vermelha, _, _, _, _, _), ListaSolucao),
    aDireita(casal(_, _, _, seteAnos, _, _), casal(_, _, _, quatroAnos, _, _), ListaSolucao),

% Daniela e o namorado dela estão bebendo vinho Italiano.
    member(casal(_, _, daniela, _, _, italiano), ListaSolucao),

% O casal que está bebendo vinho Chileno está exatamente à direita do casal que está na mesa com a vela Branca.
    diretamenteADireita(casal(_, _, _, _, _, chileno), casal(branca, _, _, _, _, _), ListaSolucao),

% Ronaldo está ao lado dos namorados que estão na mesa com a vela Azul.
    aoLado(casal(_, ronaldo, _, _, _, _), casal(azul, _, _, _, _, _), ListaSolucao),

%Testa todas as possibilidades...
    vela(Vela1),
    vela(Vela2),
    vela(Vela3),
    vela(Vela4),
    vela(Vela5),
    todosDiferentes([Vela1, Vela2, Vela3, Vela4, Vela5]),
    homem(Homem1),
    homem(Homem2),
    homem(Homem3),
    homem(Homem4),
    homem(Homem5),
    todosDiferentes([Homem1, Homem2, Homem3, Homem4, Homem5]),
    mulher(Mulher1),
    mulher(Mulher2),
    mulher(Mulher3),
    mulher(Mulher4),
    mulher(Mulher5),
    todosDiferentes([Mulher1, Mulher2, Mulher3, Mulher4, Mulher5]),
    namoro(Namoro1),
    namoro(Namoro2),
    namoro(Namoro3),
    namoro(Namoro4),
    namoro(Namoro5),
    todosDiferentes([Namoro1, Namoro2, Namoro3, Namoro4, Namoro5]),
    macarrao(Macarrao1),
    macarrao(Macarrao2),
    macarrao(Macarrao3),
    macarrao(Macarrao4),
    macarrao(Macarrao5),
    todosDiferentes([Macarrao1, Macarrao2, Macarrao3, Macarrao4, Macarrao5]),
    vinho(Vinho1),
    vinho(Vinho2),
    vinho(Vinho3),
    vinho(Vinho4),
    vinho(Vinho5),
    todosDiferentes([Vinho1, Vinho2, Vinho3, Vinho4, Vinho5]). 
