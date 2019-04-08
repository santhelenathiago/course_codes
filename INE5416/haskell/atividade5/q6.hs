-- Crie uma fun ̧c ̃ao com assinaturaocorrencias ::  [Int] -> Int -> Int,  
-- a qual recebe uma lista deInt e um Int e retorna o n ́umero de vezes em que o 
-- elemento est ́a presente na lista.N ̃ao utilizenenhumafun ̧c ̃ao pronta do Haskell para realizar esta tarefa

ocorrencias :: [Int] -> Int -> Int
ocorrencias [] x = 0
ocorrencias (a:b) x = if (a == x) then 1 + (ocorrencias b x) else (ocorrencias b x)

main = do
    let l = [1, 1, 3, 4, 2, 3, 1, 2, 3, 10]
    print (ocorrencias l 1)