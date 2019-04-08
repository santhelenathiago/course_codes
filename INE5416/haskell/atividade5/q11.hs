-- Crie uma fun ̧c ̃ao com assinaturaprimeiros ::  Int -> [t] -> [t], a qual recebe um n ́umero de ele-
-- mentos, uma lista, e retorna uma lista.  Esta fun ̧c ̃ao deve retornar uma lista com os n primeiros
-- elementosinformados no primeiro parˆametro.N ̃ao utilizenenhuma fun ̧c ̃ao pronta to Haskell para esta 
-- tarefa

primeiros :: Int -> [t] -> [t]
primeiros 0 l = []
primeiros n (a:b) = a:[] ++ primeiros (n-1) b

main = do
    let l = [1..10]
    print (primeiros 4 l)