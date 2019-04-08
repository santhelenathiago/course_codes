-- Crie uma fun ̧c ̃ao que receba trˆes notas de um aluno (a,  b,  c),  calcule a m ́edia e retorne se o aluno foiaprovado ou reprovado.  Para um aluno ser aprovado, ele deve possuir nota igual ou superior a 6.  Leia asnotas dos alunos do teclado.

media :: Float -> Float -> Float -> Float
media x y z = (x + y + z)/3

aprovado :: Float -> String
aprovado n = if n >= 6 then "aprovado" else "reprovado"

main = do
    putStrLn "Nota 1 = "
    r <- getLine
    let x = read r :: Float

    putStrLn "Nota 2 = "
    r <- getLine
    let y = read r :: Float

    putStrLn "Nota 3 = "
    r <- getLine
    let z = read r :: Float


    print ("Aluno foi " ++ (aprovado (media x y z)))
