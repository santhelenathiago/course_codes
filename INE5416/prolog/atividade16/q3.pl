numerosParaPalavras([], []).
numerosParaPalavras([1|T], L2) :- numerosParaPalavras(T, L2aux), L2 = ["Um"|L2aux].
numerosParaPalavras([2|T], L2) :- numerosParaPalavras(T, L2aux), L2 = ["Dois"|L2aux].
numerosParaPalavras([3|T], L2) :- numerosParaPalavras(T, L2aux), L2 = ["Três"|L2aux]. 
numerosParaPalavras([4|T], L2) :- numerosParaPalavras(T, L2aux), L2 = ["Quatro"|L2aux].
numerosParaPalavras([5|T], L2) :- numerosParaPalavras(T, L2aux), L2 = ["Cinco"|L2aux].
numerosParaPalavras([6|T], L2) :- numerosParaPalavras(T, L2aux), L2 = ["Seis"|L2aux].
numerosParaPalavras([7|T], L2) :- numerosParaPalavras(T, L2aux), L2 = ["Sete"|L2aux].
numerosParaPalavras([8|T], L2) :- numerosParaPalavras(T, L2aux), L2 = ["Oito"|L2aux]. 
numerosParaPalavras([9|T], L2) :- numerosParaPalavras(T, L2aux), L2 = ["Nove"|L2aux].

% ?- numerosParaPalavras([1, 2, 3, 4, 5, 6, 7], L2).
% L2 = ["Um", "Dois", "Três", "Quatro", "Cinco", "Seis", "Sete"].