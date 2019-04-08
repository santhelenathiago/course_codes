-- Crie uma fun ̧c ̃ao com assinaturafiltrar ::  (t -> Bool) -> [t] -> [t], a qual recebe uma fun ̧c ̃ao,uma  
-- lista  e  retorna  uma  nova  lista.   Esta  fun ̧c ̃ao  aplica  a  fun ̧c ̃ao  recebida  como  parˆametro  
-- sobre  cadaelemento da lista e caso o retorno da fun ̧c ̃ao for verdadeiro, ent ̃ao o elemento far ́a parte 
-- da nova lista, casocontr ́ario n ̃ao.  Para esta tarefa,utilizeo conceito delist comprehension

filtrar :: (t -> Bool) -> [t] -> [t]
filtrar func l = [b | b <- l, func b]

greater_than_4 :: Int -> Bool
greater_than_4 a = if a > 4 then True else False

main = do
    let l = [1..10]
    print (filtrar greater_than_4 l)