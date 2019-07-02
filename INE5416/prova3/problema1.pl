genitor(fred, maria).
genitor(pam, bob).
genitor(tom, bob).
genitor(pam, liz).
genitor(tom, liz).

genitor(bob, ana).
genitor(bob, pat).
genitor(bia, ana).
genitor(bia, pat).

genitor(liz, bill).
genitor(trump, bill).

genitor(mary, tim).
genitor(trump, tim).

genitor(pat, jim).
genitor(kim, jim).

mulher(maria).
mulher(pam).
mulher(bia).
mulher(liz).
mulher(mary).
mulher(ana).
mulher(pat).

homem(fred).
homem(tom).
homem(bob).
homem(trump).
homem(kim).
homem(bill).
homem(tim).
homem(jim).

idade(fred, 56).
idade(maria, 30).
idade(pam, 98).
idade(tom, 70).
idade(bob, 45).
idade(bia, 43).
idade(liz, 47).
idade(trump, 54).
idade(mary, 51).
idade(ana, 12).
idade(pat, 25).
idade(kim, 27).
idade(bill, 15).
idade(tim, 17).
idade(jim, 1).

% Item A
solteiro(X) :-
    not(genitor(X, _)).

% Item B
avo(AvoX, X) :-
    genitor(GenitorX, X),
    genitor(AvoX, GenitorX),
    homem(AvoX),
    !.

avos([]).
avos([H|T]) :-
    avo(H, _),
    avos(T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Item C
ascendente(X, Y) :-
    genitor(X, Y). %recursão - caso base
ascendente(X, Y) :-
    genitor(X, Z),
    ascendente(Z, Y). %recursão - passo recursivo
descendente(X, Y) :-
    genitor(Y, X).
descendente(X, Y) :-
    genitor(Y, GeridoY),
    descendente(X, GeridoY).

semParentesco(X, Y) :-
    ascendente(AscX, X),
    ascendente(AscY, Y),
    AscX\==AscY,
    descendente(DscX, X),
    descendente(DscY, Y),
    DscX\==DscY.

% Item D
maisVelha(X, Y) :-
    idade(X, IX),
    idade(Y, IY),
    IX>IY.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Item E
% temFilhoMenorDeIdade(Genitor) :-
%     genitor(Genitor, Filho),
%     idade(Filho, Idade),
%     Idade=<17,
%     !.
% findall(Pessoa,
%         (   
%             genitor(Pessoa, Filho),
%             not(temFilhoMenorDeIdade(Pessoa))
%         ;   
%             idade(Pessoa, _),
%             not(genitor(Pessoa, _))
%         ),
%         P),
% list_to_set(P, LP),
% sort(LP, Resultado),
% length(Resultado, Len).


% Item F
% setof(Pessoa, 
%     _IP ^ _F ^(
%         genitor(Pessoa, _F),
%         idade(Pessoa, _IP),
%         _IP =< 70,
%         _IP >= 30
%     ),
%     Pessoas).

%Item G
% bagof(Asc, (homem(H), ascendente(Asc ,H)), Ascendentes).
