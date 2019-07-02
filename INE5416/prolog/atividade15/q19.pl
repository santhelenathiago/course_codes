mdc(X, Y, Resultado) :- X = Y, Resultado = X.   % Case base
mdc(X, Y, Resultado) :-
  X < Y,                % X tem que ser menor do que Y
  Y1 is Y - X,          % Subtrai X de Y
  mdc(X, Y1, Resultado).        % recursivamente
mdc(X, Y, Resultado) :- X > Y, mdc(Y, X, Resultado).  % Inverte X > Y

coprimos(X,Y) :- mdc(X, Y, GCD), GCD is 1.

totienteEulerCont(N, N, K) :- K is 1.
totienteEulerCont(N, C, K) :- CM1 is C+1, totienteEulerCont(N, CM1, Ka), 
                        (coprimos(N, C) 
                            -> K is Ka+1
                            ; K is Ka

                        ).

totienteEuler(1, K) :- K is 1.
totienteEuler(N, K) :- totienteEulerCont(N, 1, K).

% ?- totienteEuler(1, K).
% K = 1 .

% ?- totienteEuler(10, K).
% K = 4 .

% ?- totienteEuler(10, K).
% K = 4 .

% ?- totienteEuler(28, K).
% K = 13 .