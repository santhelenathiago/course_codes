-- Motifique o arquivoalunos.hs(dispon ́ıvel no Moodle) de forma a adicionar novas fun ̧c ̃oes:
-- A:Crie uma fun ̧c ̃ao com a seguinte assinatura:aprovados ::  [(Int, String, Float)] -> [String],a 
--     qual recebe uma lista de alunos e retorna uma lista com o nome dos alunos aprovados.  
--     Um alunoest ́a aprovado se a sua m ́edia  ́e maior ou igual a 6.  Utilizemapefilterpara 
--     resolver esta quest ̃ao.
-- B:Crie uma fun ̧c ̃ao com a seguinte assinatura:aprovados2 ::  [(Int, String, Float)] -> [String],a 
--     qual recebe uma lista de alunos e retorna uma lista com o nome dos alunos aprovados.  
--     Um alunoest ́a  aprovado  se  a  sua  m ́edia   ́e  maior  ou  igual  a  6.   
--     N ̃ao utilizemapefilterpara  resolver  estaquest ̃ao.Utilizeo conceito delist comprehension.
-- C:Utilize  (e  modifique,  se  necess ́ario)  a  fun ̧c ̃aogerarParesvista  em  aula  e  
--     dispon ́ıvel  no  arquivoalunos.hspara formar duplas de alunos.  Note que um aluno
--     n ̃ao pode fazer dupla consigo mesmo


alunos :: [(Int, String, Float)]
alunos = [(1, "Ana", 3.4), (2, "Bob", 6.7), (3, "Tom", 7.6)]

getNome :: (Int, String, Float) -> String
getNome (a,b,c) = b

getPrimeiroAluno :: [(Int, String, Float)] -> (Int, String, Float)
getPrimeiroAluno (a:_) = a

gerarPares :: [(Int, String, Float)] -> [(Int, String, Float)] -> [((Int, String, Float),(Int, String, Float))] 
gerarPares l1 l2 = [(a,b) | a <- l1, b <- l2, (differ a b)]
    where
        differ x y = (getNome x) /= (getNome y)

aprovado :: (Int, String, Float) -> Bool
aprovado (a, b, c) = if c >= 6.0 then True else False

aprovados :: [(Int, String, Float)] -> [String]
aprovados a = (map getNome (filter aprovado a))

aprovados2 :: [(Int, String, Float)] -> [String]
aprovados2 list = [getNome b | b <- list, aprovado b]

main = do
    print "Com filter e map"
    print (aprovados alunos)

    print "Sem filter e map"
    print (aprovados2 alunos)

    print "Pares"
    print (gerarPares alunos alunos)