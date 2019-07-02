distancia3D(ponto(X1,Y1,Z1),ponto(X2,Y2,Z2),  Dist) :- Xd is X1-X2, Xds is Xd*Xd,
                                                       Yd is Y1-Y2, Yds is Yd*Yd,
                                                       Zd is Z1-Z2, Zds is Zd*Zd,
                                                       Sum is Xds+Yds+Zds, Dist is sqrt(Sum).

% ?- distancia3D(ponto(0, 0, 0), ponto(0, 0, 1), Dist).
% Dist = 1.0.

% ?- distancia3D(ponto(0, 0, 0), ponto(0, 1, 1), Dist).
% Dist = 1.4142135623730951.