-- Crie uma fun ̧c ̃ao com assinaturaapagarEnquanto ::  (t -> Bool) -> [t] -> [t], a qual 
-- recebe umafun ̧c ̃ao como parˆametro e uma lista, e retorna uma lista.  Esta fun ̧c ̃ao deve 
-- aplicar a fun ̧c ̃ao passada comoparˆametro a cada elemento da lista, at ́e que algum elemento 
-- da lista retorneFalsena aplica ̧c ̃ao da fun ̧c ̃ao.Os elementos da lista resultante s ̃ao ent ̃ao 
-- todos os elementos a partir do elemento em que a fun ̧c ̃ao passadacomo  parˆametro  retornouFalse.   
-- Por  exemplo  a  chamada(apagarEnquanto par [2,4,1,2,3,4,5])deve retornar[1,2,3,4,5], visto que 
-- ao testar o elemento 1, a fun ̧c ̃aoparretornaFalse.N ̃ao utilizenenhuma fun ̧c ̃ao pronta to Haskell 
-- para esta tarefa.

apagarEnquanto :: (t -> Bool) -> [t] -> [t]
apagarEnquanto func [] = []
apagarEnquanto func (a:b) = if (func a) then a:[] ++ (apagarEnquanto func b) else apagarEnquanto func b

enquanto :: Int -> Bool
enquanto x = x > 5

main = do
    let l = [1..10]
    print (apagarEnquanto enquanto l)