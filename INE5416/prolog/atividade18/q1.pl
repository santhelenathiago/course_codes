% Amigo Secreto

camisa(amarela).
camisa(azul).
camisa(branca).
camisa(verde).
camisa(vermelha).

nome(artur).
nome(caio).
nome(julio).
nome(rogerio).
nome(mateus).

presente(caneca).
presente(dvd).
presente(gravata).
presente(jaqueta).
presente(livro).

amigo(alessandro).
amigo(denis).
amigo(celso).
amigo(fabiano).
amigo(wagner).

hobby(cantar).
hobby(dancar).
hobby(desenhar).
hobby(pintar).
hobby(ler).

esporte(futebol).
esporte(squash).
esporte(surf).
esporte(volei).
esporte(natacao).

%X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).
                       
%X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X), 
                        nth0(IndexY,Lista,Y), 
                        IndexX < IndexY.
                        
%X está à direita de Y (em qualquer posição à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista). 

%X está na ponta se ele é o primeiro ou o último da lista
naPonta(X,Lista) :- last(Lista,X).
naPonta(X,[X|_]).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

solucao(ListaSolucao) :- 

    ListaSolucao = [
        pessoa(Camisa1, Nome1, Presente1, Amigo1, Hobby1, Esporte1),
        pessoa(Camisa2, Nome2, Presente2, Amigo2, Hobby2, Esporte2),
        pessoa(Camisa3, Nome3, Presente3, Amigo3, Hobby3, Esporte3),
        pessoa(Camisa4, Nome4, Presente4, Amigo4, Hobby4, Esporte4),
        pessoa(Camisa5, Nome5, Presente5, Amigo5, Hobby5, Esporte5)
    ],

    % Em uma das pontas está quem pratica Natação
    naPonta(pessoa(_, _, _, _, _, natacao), ListaSolucao),

    % Quem gosta de Pintar também gosta de Futebol.
    member(pessoa(_, _, _, _, pintar, surf), ListaSolucao),

    % Quem tirou o Alessandro está ao lado de quem pratica Surf.
    aoLado(pessoa(_, _, _, alessandro, _, _),
           pessoa(_, _, _, _, _, surf),
           ListaSolucao),

    % Quem tirou o Denis joga Squash.
    member(pessoa(_, _, _, denis, _, squash), ListaSolucao),

    % Na quinta posição está que gosta de Cantar.
    Hobby5 = cantar,

    % O rapaz que gosta de Surf também gosta de Desenhar.
    member(pessoa(_, _, _, _, desenhar, surf), ListaSolucao),

    % Quem gosta de Futebol está ao lado de quem gosta de Cantar.
    aoLado(pessoa(_, _, _, _, _, futebol),
           pessoa(_, _, _, cantar, _),
           ListaSolucao),

    % Mateus está exatamente à direita de quem gosta de Ler.
    aDireita(pessoa(_, mateus, _, _, _, _), 
             pessoa(_, _, _, ler, _),
             ListaSolucao),
    
    % O rapaz de Azul e o que gosta de surfar estão lado a lado.
    aoLado(pessoa(azul, _, _, _, _, _),
           pessoa(_, _, _, _, _, surf),
           ListaSolucao),

    % Quem tirou o Fabiano está em uma das pontas.
    naPonta(pessoa(_, _, _, fabiano, _, _),
            ListaSolucao),

    % O homem de Azul está em algum lugar à esquerda de quem tirou o Wagner.
    aEsquerda(pessoa(azul, _, _, _, _, _), pessoa(_, _, _, wagner, _, _),
              ListaSolucao),

    % Quem tirou o Celso está ao lado de quem gosta de Desenhar.
    aoLado(pessoa(_, _, _, celso, _, _),
           pessoa(_, _, _, _, desenhar, _),
           ListaSolucao),

    % Quem tirou o Wagner está exatamente à esquerda de quem tirou o Alessandro.
    aoLado(pessoa(_, _, _, wagner, _, _),
           pessoa(_, _, _, alessandro, _, _), 
           ListaSolucao),
    aEsquerda(pessoa(_, _, _, wagner, _, _),
              pessoa(_, _, _, alessandro, _, _), 
              ListaSolucao),

    % Mateus está ao lado de quem pratica Squash.
    aoLado(pessoa(_, mateus, _, _, _, _),
           pessoa(_, _, _, _, _, squash), 
           ListaSolucao),

    % Na quinta posição está quem vai dar um Livro de presente.
    Presente5 = livro,

    % O homem de Branco dará uma Gravata de presente.
    member(pessoa(branco, _, gravata, _, _, _), ListaSolucao),

    % Quem vai dar um DVD de presente está exatamente à direita de quem está de Branco.
    aoLado(pessoa(_, _, dvd, _, _, _),
           pessoa(branco, _, _, _, _, _), 
           ListaSolucao),
    aDireita(pessoa(_, _, dvd, _, _, _),
             pessoa(branco, _, _, _, _, _), 
             ListaSolucao),
    
    % Caio está ao lado de quem vai dar um Jaqueta de presente.
    aoLado(pessoa(_, caio, _, _, _, _),
           pessoa(_, _, jaqueta, _, _, _),
           ListaSolucao),
    
    % Arthur está em uma das pontas.
    naPonta(pessoa(_, artur, _, _, _, _), ListaSolucao),

    % Rogério está na terceira posição.
    Nome3 = rogerio,

    % O rapaz de Amarelo está ao lado de quem pratica Surf.
    aoLado(pessoa(amarelo, _, _, _, _, _),
           pessoa(_, _, _, _, _, surf),
           ListaSolucao),

    % Júlio está exatamente à direita de Rogério.
    aoLado(pessoa(_, julio, _, _, _, _),
           pessoa(_, rogerio, _, _, _, _), 
           ListaSolucao),
    aDireita(pessoa(_, julio, _, _, _, _),
             pessoa(_, rogerio, _, _, _, _), 
             ListaSolucao),

    % O rapaz de Vermelho está em algum lugar à esquerda do Arthur.
    aEsquerda(pessoa(vermelha, _, _, _, _, _),
              pessoa(_, artur, _, _, _, _),
              ListaSolucao),

    %  Testa todas as possibilidade

    camisa(Camisa1),
    camisa(Camisa2),
    camisa(Camisa3),
    camisa(Camisa4),
    camisa(Camisa5),
    todosDiferentes([Camisa1, Camisa2, Camisa3, Camisa4, Camisa5]),
    nome(Nome1),
    nome(Nome2),
    nome(Nome3),
    nome(Nome4),
    nome(Nome5),
    todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),
    presente(Presente1),
    presente(Presente2),
    presente(Presente3),
    presente(Presente4),
    presente(Presente5),
    todosDiferentes([Presente1, Presente2, Presente3, Presente4, Presente5]),
    amigo(Amigo1),
    amigo(Amigo2),
    amigo(Amigo3),
    amigo(Amigo4),
    amigo(Amigo5),
    todosDiferentes([Amigo1, Amigo2, Amigo3, Amigo4, Amigo5]),
    hobby(Hobby1),
    hobby(Hobby2),
    hobby(Hobby3),
    hobby(Hobby4),
    hobby(Hobby5),
    todosDiferentes([Hobby1, Hobby2, Hobby3, Hobby4, Hobby5]),
    esporte(Esporte1),
    esporte(Esporte2),
    esporte(Esporte3),
    esporte(Esporte4),
    esporte(Esporte5),
    todosDiferentes([Esporte1, Esporte2, Esporte3, Esporte4, Esporte5]).