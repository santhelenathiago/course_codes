mdc(X, Y, Resultado) :- X = Y, Resultado = X.   % Case base
mdc(X, Y, Resultado) :-
  X < Y,                % X tem que ser menor do que Y
  Y1 is Y - X,          % Subtrai X de Y
  mdc(X, Y1, Resultado).        % recursivamente
mdc(X, Y, Resultado) :- X > Y, mdc(Y, X, Resultado).  % Inverte X > Y

mmc(X,Y,Resultado) :- mdc(X, Y, GCD), Product is X*Y, Resultado is Product/GCD.

% ?- mmc(13, 12, R).
% R = 156 .

% ?- mmc(3, 6, R).
% R = 6 .

% ?- mmc(15, 20, R).
% R = 60 .