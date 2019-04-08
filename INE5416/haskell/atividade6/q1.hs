-- Crie um tipo de dados Aluno, usando type, assim como criamos um tipo de dados Pessoa.  O 
-- tipo Alunodeve possuir um campo para o nome,  outro para a disciplina e outros tres campos 
-- para notas.  Agora,execute os passos abaixo:
-- A:Crie uma função no mesmo estilo que a função pessoa, 
-- vista em sala e dispon ıvel nos slides no Moodle,ou seja, que receba um inteiro e retorne um Aluno 
-- correspondente ao valor inteiro.
-- B:Crie alguns alunos de exemplo, assim como tamb ́em feito no exemplo da pessoa.
-- C:No  main,  imprima  o  primeiro  nome  de  um  aluno,  portanto  crie  uma  função  para
--  obter  o  primeironome.
--  D:Crie uma função que receba um Int e retorne a m ́edia do aluno correspondente.
--  E:Crie uma função que calcule a m ́edia da turma, ou seja, considerando todos os alunos.  
--  DICA:  crieuma função recursiva que receba o primeiro identificador de aluno e incremente o 
--  identificador a cadachamada recursiva, at ́e chegar no  ́ultimo aluno.  N ̃ao use listas!

type Nome = String
type Nota = Float
type Disciplina = String

type Aluno = (Nome, Disciplina, Nota, Nota, Nota)

n_alunos :: Int
n_alunos = 3

aluno :: Int -> Aluno
aluno 1 = ("Albert Einstein", "Fisica", 10, 10, 10)
aluno 2 = ("Immanuel Kant", "Matematica", 6, 5, 8)
aluno 3 = ("Edsger Dijkstra", "POO1", 10, 0, 0)

get_notas :: Aluno -> [Float]
get_notas (_, _, n1, n2, n3) = [n1, n2, n3]

nome_do :: Aluno -> String
nome_do (nome, _, _, _, _) = nome

primeiro_aluno :: Aluno
primeiro_aluno = aluno 1

media :: Int -> Float
media i = (sum (get_notas (aluno i)) )/3

soma_medias :: Int -> Float
soma_medias n | (n <= n_alunos) = (media  n) + (soma_medias (n+1))
              | otherwise = 0

media_alunos :: Float
media_alunos = (soma_medias 1)/(fromIntegral n_alunos)


main = do
    print (nome_do (primeiro_aluno))

    print (media 1)
    print (media 2)
    print (media 3)
    print (soma_medias 1)

    print (media_alunos)


