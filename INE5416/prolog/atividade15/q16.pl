mdc_2(X, Y, Resultado) :- X = Y, Resultado = X.   % Case base
mdc_2(X, Y, Resultado) :-
  X < Y,                % X tem que ser menor do que Y
  Y1 is Y - X,          % Subtrai X de Y
  mdc_2(X, Y1, Resultado).        % recursivamente
mdc_2(X, Y, Resultado) :- X > Y, mdc_2(Y, X, Resultado).  % Inverte X > Y

mdc(X, Y, Z, Resultado) :- mdc_2(X, Y, Resultado_t), mdc_2(Z, Resultado_t, Resultado).

% ?- mdc(37, 21, 49,M).
% M = 1 .

% ?- mdc(35, 21, 49,M).
% M = 7 .

% ?- mdc(302, 1172, 112,M).
% M = 2 .