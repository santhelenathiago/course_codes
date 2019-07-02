mdc(X, Y, Resultado) :- X = Y, Resultado = X.   % Case base
mdc(X, Y, Resultado) :-
  X < Y,                % X tem que ser menor do que Y
  Y1 is Y - X,          % Subtrai X de Y
  mdc(X, Y1, Resultado).        % recursivamente
mdc(X, Y, Resultado) :- X > Y, mdc(Y, X, Resultado).  % Inverte X > Y

% ?- mdc(9, 21, M).
% M = 3 .

% ?- mdc(14, 21, M).
% M = 7 .

% ?- mdc(37, 21, M).
% M = 1 .