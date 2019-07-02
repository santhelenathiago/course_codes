:- include('dvd.pl').

% item a
% ?- findall(Nome, (filme(F, Nome, Ano, Diretor, Nacionalidade), Ano < 2001) , L).
% L = ['Monty Python: O Sentido da Vida'].

% item b
% ?- findall(Nome, (filme(F, Nome, Ano, Diretor, Nacionalidade), Ano >= 2001,  2004 >= Ano) , L).
% L = ['Edukators', 'Lavoura Arcaica', 'Lisbela e o Prisioneira', 'Abril despeda�ado', 'Di�rios de motocicleta'].

% item c
% ?- findall(Titulo, (filme(Filme, Titulo, Ano, Diretor, Nacionalidade), pais(Nacionalidade, NomePais), NomePais = 'Brasil'), T), sort(T, TOrdenados).
% T = ['Lavoura Arcaica', 'Lisbela e o Prisioneira', 'Abril despeda�ado', 'Di�rios de motocicleta'],
% TOrdenados = ['Abril despeda�ado', 'Di�rios de motocicleta', 'Lavoura Arcaica', 'Lisbela e o Prisioneira'].

% item d
% ?- findall(Titulo, (filme(Filme, Titulo, Ano, Diretor, Nacionalidade), pais(Nacionalidade, NomePais), not(NomePais = 'Brasil')), T), sort(T, TOrdenados).
% T = ['Monty Python: O Sentido da Vida', 'Edukators'],
% TOrdenados = ['Edukators', 'Monty Python: O Sentido da Vida'].

% item e
% ?- findall((Titulo, Diretor), (filme(F, Titulo, A, Diretor, N), 2004 >= A, pais(N, NomePais), NomePais = 'Alemanha'), L).
% L = [('Edukators', 'Hans Weingartner')].

% item f
% ?- findall(Id, (filme(F, T, A, D, N), pais(N, NomePais), not(NomePais = 'Brasil'), dvd(Id, F, __)), Ids).
% Ids = [d1, d6, d2, d7, d8].

% item g
% ?- findall(Id, (filme(F, T, A, D, N), pais(N, NomePais), not(NomePais = 'Brasil'), dvd(Id, F, __)), Ids).
% Ids = [d1, d6, d2, d7, d8].

% item h
% ?- findall(D, (filme(F, T, A, D, N), dvd(_, F, est1)), Diretores), sort(Diretores, DiretoresOrdenados).
% Diretores = ['Terry Jones', 'Terry Jones', 'Hans Weingartner', 'Guel Arraes'],
% DiretoresOrdenados = ['Guel Arraes', 'Hans Weingartner', 'Terry Jones'].]

% item i
% ?- findall(T, (filme(F, T, A, D, N), not(dvd(Id, F, __))), F).
% F = ['Di�rios de motocicleta'].

% item j
% ?- findall(NomePais, (filme(F, T, A, D, N), (dvd(_, F, est1) ; dvd(__, F, est4)), pais(N, NomePais)), P), list_to_set(P, PSemRepetirNomes).
% P = ['Unided Kingdom', 'Unided Kingdom', 'Alemanha', 'Alemanha', 'Alemanha', 'Brasil'],
% PSemRepetirNomes = ['Unided Kingdom', 'Alemanha', 'Brasil'].

% item k
% ?- findall(Cliente, (locacao(Cod, _, Data), Data = '2005-11-07', cliente(Cod, Cliente, __)), Cs), list_to_set(Cs, Clientes).
% Cs = ['Bob', 'Bob'],
% Clientes = ['Bob'].

% item l
% ?- findall(Est, (locacao(_, Dvd, __), dvd(Dvd, ___, Est)), Ests), list_to_set(Ests, Estantes).
% Ests = [est1, est1, est3, est2, est2, est4, est4, est1, est3|...],
% Estantes = [est1, est3, est2, est4].

% item m
% ?- findall(T, (locacao(Cod, Dvd, _), dvd(Dvd, F, _), filme(F, T, _, _, _), cliente(Cod, NomeCliente, _), NomeCliente = 'Maria'), Titulos).
% Titulos = ['Monty Python: O Sentido da Vida', 'Edukators'].

% item n
% ?- findall(T, (locacao(Cod, Dvd, _), dvd(Dvd, F, _), filme(F, T, _, _, _), cliente(Cod, NomeCliente, _), NomeCliente = 'Maria'), Ts), list_to_set(Ts, T), length(T, QuantidadeDeFilmesAlugadosPorMaria).
% T = Ts, Ts = ['Monty Python: O Sentido da Vida', 'Edukators'],
% QuantidadeDeFilmesAlugadosPorMaria = 2.

% item o
% ?- bagof(T, IdF ^ _IdDVD ^ _A ^ _D ^ _N ^(dvd(_IdDVD, IdF, Est), filme(IdF, T, _A, _D, _N)) , Titulos).
% Est = est1,
% Titulos = ['Monty Python: O Sentido da Vida', 'Edukators', 'Lisbela e o Prisioneira', 'Monty Python: O Sentido da Vida'] ;
% Est = est2,
% Titulos = ['Lavoura Arcaica'] ;
% Est = est3,
% Titulos = ['Abril despeda�ado'] ;
% Est = est4,
% Titulos = ['Edukators', 'Edukators'].

% item p
% ?- findall(NP, (filme(F, _T, _A, _D, N), pais(N, NP), dvd(IdDVD, F, _Est), locacao(C, IdDVD, Data), cliente(C, NomeCliente, _Telefone), NomeCliente = 'Bob', Data = '2005-11-07'), NomePaises).
% NomePaises = ['Unided Kingdom', 'Alemanha'].

% item q
% ?- findall(NP, (filme(F, _T, _A, _D, N), pais(N, NP), dvd(IdDVD, F, _Est), locacao(C, IdDVD, Data), cliente(C, NomeCliente, _Telefone), NomeCliente = 'Bob', NP = 'Brasil'), NPs), length(NPs, QtdFilmesBrasileirosAlugadosPorBob).
% NPs = ['Brasil'],
% QtdFilmesBrasileirosAlugadosPorBob = 1.

% itm r
% ?- setof(T, F ^ _A ^ _D ^ _N ^ IdDVD ^ Est ^ F ^ C ^_Data ^ _Tel ^ (filme(F, T, _A, _D, _N), dvd(IdDVD, F, Est), locacao(C, IdDVD, _Data), cliente(C, Cliente, _Tel)), Filmes).
% Cliente = 'Alice',
% Filmes = ['Edukators', 'Monty Python: O Sentido da Vida'] ;
% Cliente = 'Bianca',
% Filmes = ['Edukators'] ;
% Cliente = 'Bob',
% Filmes = ['Abril despeda�ado', 'Edukators', 'Monty Python: O Sentido da Vida'] ;
% Cliente = 'Maria',
% Filmes = ['Edukators', 'Monty Python: O Sentido da Vida'] ;
% Cliente = 'Tom',
% Filmes = ['Abril despeda�ado', 'Edukators', 'Lavoura Arcaica'] ;
% Cliente = 'Zeca',
% Filmes = ['Lavoura Arcaica'].

% item s
% ?- findall(F, (locacao(c2, Idvd1, _), locacao(c3, Idvd2, _), dvd(Idvd1, IdF, _), dvd(Idvd2, IdF, _), filme(IdF, F, _, _, _)), Filmes).
% Filmes = ['Lavoura Arcaica'].

% item t
% ?- findall(T, (filme(F, T, _, _, _), dvd(Idvd, F, _), locacao(c1, Idvd, _), not((dvd(Idvd1, F, _), locacao(c6, Idvd1, _)))), Filmes).
% Filmes = ['Abril despeda�ado'].

% item u
% ?- findall(T, (
%             filme(F, T, _, _, _),
%             not(
%                 (   
%                     locacao(c1, IdvdB, _), 
%                     locacao(c6, IdvdM, _), 
%                     (dvd(IdvdB, F, _) ;
%                     dvd(IdvdM, F, _))
%                 )
%             )
%             ), Filmes).
% Filmes = ['Lavoura Arcaica', 'Lisbela e o Prisioneira', 'Di�rios de motocicleta'].