-- Crie uma função com assinatura soma ::  [Int] -> Int, a qual recebe uma lista de Int e 
-- retorna a somade todos os elementos da lista.  Retorne 0 caso a lista for vazia.N ̃ao 
-- utilize nenhuma função pronta do Haskell para realizar esta tarefa.

soma :: [Int] -> Int
soma [] = 0
soma (a:b) = a + (soma b)

main = do
    let l = [1..10]
    print (soma l)