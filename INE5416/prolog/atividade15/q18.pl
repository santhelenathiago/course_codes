mdc(X, Y, Resultado) :- X = Y, Resultado = X.   % Case base
mdc(X, Y, Resultado) :-
  X < Y,                % X tem que ser menor do que Y
  Y1 is Y - X,          % Subtrai X de Y
  mdc(X, Y1, Resultado).        % recursivamente
mdc(X, Y, Resultado) :- X > Y, mdc(Y, X, Resultado).  % Inverte X > Y


coprimos(X,Y) :- mdc(X, Y, GCD), GCD is 1.

% ?- coprimos(13, 14).
% true .

% ?- coprimos(12, 14).
% false.

% ?- coprimos(327, 3021).
% false.