-- Crie uma fun ̧c ̃ao com assinaturamedia ::  [Int] -> Float, a qual recebe 
-- uma lista de Int e retornaa m ́edia de todos os elementos da lista.  
-- Retorne 0 caso a lista for vazia.N ̃ao utilizenenhuma fun ̧c ̃aopronta 
-- do Haskell para realizar esta tarefa.  DICA: utilize a 
-- fun ̧c ̃aofromIntegralpara converter um tipointeiro para um tipo 
-- compat ́ıvel com o operador de divis ̃ao/
sum :: [Int] -> Int
sum [] = []
sum (a:b) = a + sum b

len :: [Int] -> Int
len [] = []
len (_:b) = 1 + len b

media :: [Int] -> Float
media [] = 0
media (a:b) = (fromIntegral (sum (a:b))) / (len (a:b))

main = do
    let l = [1..10]
    print (show (media l)) 