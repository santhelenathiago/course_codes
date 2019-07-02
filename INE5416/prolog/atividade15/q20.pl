divisivel(Divididendo, Divisor) :- R is Divididendo/Divisor, R = 0.

divisivelRecursivo(N, C) :- CM1 is C+1, Sq is sqrt(N), (CM1 > Sq -> divisivelRecursivo(N, CM1 ; true)), \+ divisivel(N, C).

primo(1) :- false.
primo(2). 
primo(N) :- divisivelRecursivo(N, 1).