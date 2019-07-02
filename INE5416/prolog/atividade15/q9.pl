xor(true, true) :- false.
xor(true, false) :- true.
xor(false, true) :- true.
xor(false, false) :- false.

% ?- xor(true, true).
% false.

% ?- xor(false, true).
% true .

% ?- xor(true, false).
% true.

% ?- xor(false, false).
% false.