-- Crie uma fun ̧c ̃ao com assinaturadiferencaMaiorMenor ::  [Int] -> Int, a qual 
-- recebe uma lista deInt e retorna a diferen ̧ca entre o maior e o menor elemento 
-- da lista.  Retorne 0 caso a lista for vazia.N ̃aoutilizenenhuma fun ̧c ̃ao pronta do 
--     Haskell para realizar esta taref


menor :: [Int] -> Int
menor [] = 0
menor [a] = a
menor (a:b:c) = if a < b then (menor (a:c)) else (menor (b:c)) 

maior :: [Int] -> Int
maior [] = 0
maior [a] = a
maior (a:b:c) = if a > b then (maior (a:c)) else (maior (b:c)) 

main = do
    let l = [1..10]
    print (show ((maior l) - (menor l)))