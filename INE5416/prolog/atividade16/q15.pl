membro(X,[X|_]) :- !.
membro(X,[_|T]) :- membro(X,T).

diferenca([], _, []).
diferenca([H|T], S2, S3) :- membro(H, S2) ->
                                diferenca(T, S2, S3) 
                            ;
                                diferenca(T, S2, SS3), S3 = [H|SS3].

% ?- diferenca([1, 2, 3, 5], [2, 3, 4], L).
% L = [1, 5].