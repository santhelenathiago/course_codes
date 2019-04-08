-- Crie uma fun ̧c ̃ao com assinaturainverte ::  [t] -> [t], a qual recebe uma lista como parˆametro e
-- deve retornar a mesma invertida.N ̃ao utilizenenhuma fun ̧c ̃ao pronta do Haskell para realizar esta tarefa.

inverte :: [Int] -> [Int]
inverte [x, y] = [y, x]
inverte (a:b) = (inverte b) ++ a:[]

main = do
    let l = [1..10]
    print (inverte l)