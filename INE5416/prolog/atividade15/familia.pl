%          pam        tom
%            |________| |_____
%                |            |
%               bob          liz
%            ____|            |______
%       ____|____                    |
%      |         |                   |
%     ana       pat                 bill
%                |____
%                     |
%                    jim

genitor(pam, bob).
genitor(tom, bob).
genitor(tom, liz).

genitor(bob, ana).
genitor(bob, pat).

genitor(liz,bill).

genitor(pat, jim).

mulher(pam).
mulher(liz).
mulher(pat).
mulher(ana).
homem(tom).
homem(bob).
homem(jim).
homem(bill).

pai(X, Y) :- genitor(X,Y), homem(X).
mae(X, Y) :- genitor(X,Y), mulher(X).

avo(AvoX, X) :- genitor(GenitorX, X), genitor(AvoX, GenitorX), homem(AvoX).
avoh(AvohX, X) :- genitor(GenitorX, X), genitor(AvohX, GenitorX), mulher(AvohX).
irmao(X, Y) :- genitor(PaiAmbos, X), genitor(PaiAmbos, Y), X \== Y, homem(X).
irma(X, Y) :- genitor(PaiAmbos, X), genitor(PaiAmbos, Y), X \== Y, mulher(X).
irmaos(X, Y) :- (irmao(X,Y); irma(X,Y)), X \== Y.

ascendente(X, Y) :- genitor(X,Y). %recursão - caso base
ascendente(X, Y) :- genitor(X, Z), ascendente(Z, Y). %recursão - passo recursivo

% tio(bob, bill).
% true.
% tio(ana, jim).
% false.
tio(X, Y) :- genitor(GenitorY, Y), irmaos(GenitorY, X), X \== Y, homem(X).
% tia(bob, bill).
% false.
% tia(ana, jim).
% true.
tia(X, Y) :- genitor(GenitorY, Y), irmaos(GenitorY, X), X \== Y, mulher(X).

% primo(bob, pam).
% false
% primo(bill, pat).
% true.
% primo(pat, bill).
% false.
primo(X, Y) :- genitor(GenitorX, X), genitor(GenitorY, Y), homem(X), irmaos(GenitorX, GenitorY), X \== Y.
% prima(bob, pam).
% false.
% prima(bill, pat).
% false.
% prima(pat, bill).
% true.
prima(X, Y) :- genitor(GenitorX, X), genitor(GenitorY, Y), mulher(X), irmaos(GenitorX, GenitorY), X \== Y.

% bisavo(tom, jim).
% true.
% bisavo(bob, jim).
% false.
bisavo(X, Y) :- X \== Y, ((avo(Avo, Y), pai(X, Avo)) ; (avoh(Avoh, Y), pai(X, Avoh))).

% bisavoh(pam, jim).
% true.
% bisavoh(pam, pat).
% false.
bisavoh(X, Y) :- X \== Y, ((avo(Avo, Y), mae(X, Avo)) ; (avoh(Avoh, Y), mae(X, Avoh))).


% descedente(bill, pam).
% false.
% Porque o tom deu uma pulada de cerca

% descendente(ana, pam).
% true.
% Porque ana é filha do bob que é filho da pam
descendente(X, Y) :- genitor(Y, X).
descendente(X, Y) :- genitor(Y, GeridoY), descendente(X, GeridoY).

% feliz(bob).
% true.
% feliz(bill).
% false.
feliz(X) :- genitor(X, _). 

% Regra criada: filho_juntos(X, Y) onde X e Y geraram um filho
% filho_juntos(tom, pam).
% true.
% filho_juntos(tom, bob).
% false.
% filho_juntos(bill, ana).
% false.

filho_juntos(X, Y) :- ((homem(X), mulher(Y));(homem(Y), mulher(X))), X \== Y, genitor(X, F), genitor(Y, F). 