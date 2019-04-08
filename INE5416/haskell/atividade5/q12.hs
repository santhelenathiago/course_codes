-- Crie uma fun ̧c ̃ao com assinaturaapagar ::  Int -> [t] -> [t], a qual recebe um n ́umero de elementos,
-- uma lista,  e  retorna uma lista.  Esta  fun ̧c ̃ao  deve remover da lista os  n primeiros elementos 
-- fornecidoscomo parˆametro.  Por exemplo, a chamada(apagar 3 [1,2,3,4,5])deve retornar[4,5].
-- N ̃ao utilizenenhuma fun ̧c ̃ao pronta to Haskell para esta tarefa

apagar :: Int -> [t] -> [t]
apagar 0 a = a
apagar n (a:b) = apagar (n-1) b

main = do
    let l = [1..10]
    print (apagar 5 l)