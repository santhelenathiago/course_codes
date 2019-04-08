-- Crie uma fun ̧c ̃ao com assinaturamenor ::  [Int] -> Int, a qual recebe uma lista de 
-- Int e retorna omenor elemento da lista.  Retorne 0 caso a lista for vazia.N ̃ao utilizenenhuma 
-- fun ̧c ̃ao pronta do Haskellpara realizar esta tarefa.

menor :: [Int] -> Int
menor [] = 0
menor [a] = a
menor (a:b:c) = if a < b then (menor (a:c)) else (menor (b:c)) 

main = do
    let l = [-8..10]
    print (show (menor l)) 