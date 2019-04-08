-- Crie uma fun ̧c ̃ao com assinaturamapear ::  (t -> y) -> [t] -> [y], a qual recebe uma fun ̧c ̃ao, 
-- umalista e retorna uma lista.  Esta fun ̧c ̃aomapearfar ́a o mesmo que a fun ̧c ̃aomap, ou seja, 
-- aplicar a fun ̧c ̃aorecebida como parˆametro sobre cada elemento da lista e retornar a lista 
-- resultante.N ̃ao utilize mapoufilterpara esta tarefa.1

mapear :: (t -> y) -> [t] -> [y]
mapear func l = [func b | b <- l]

invert :: Int -> Int
invert a = (-1) * a

main = do
    let l = [1..10]
    print (mapear invert l)