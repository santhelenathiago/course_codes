-- Crie uma fun ̧c ̃ao com assinaturabusca ::  [Int] -> Int -> Bool, a qual recebe uma lista de 
-- Int e umInt e retorna se o elemento passado como parˆametro encontra-se na lista ou n ̃ao.N ̃ao 
-- utilizenenhumafun ̧c ̃ao pronta do Haskell para realizar esta tarefa.

busca :: [Int] -> Int -> Bool
busca [] x = False
busca (a:b) x = if (a == x) then True else (busca b x) 

main = do
    let l = [1..10]
    print (busca l (-1))