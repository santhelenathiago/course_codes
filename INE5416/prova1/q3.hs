data Arvore = Null | No Int Arvore Arvore

minhaArvore :: Arvore
minhaArvore = No 52 (No 31 (No 12 Null Null) (No 35 Null Null)) (No 56 (No 55 Null Null) (No 64 Null Null))

minhaArvoreRep :: Arvore
minhaArvoreRep = No 52 (No 31 (No 11 Null Null) (No 11 Null Null)) (No 31 (No 55 Null Null) (No 55 Null Null))

somaElementos :: Arvore -> Int
somaElementos Null = 0
somaElementos (No n esq dir) = n + (somaElementos esq) + (somaElementos dir)

buscaElemento :: Arvore -> Int -> Bool
buscaElemento Null _ = False
buscaElemento (No n esq dir) x 
    | (n == x) = True                           
    | otherwise = (buscaElemento esq x) || (buscaElemento dir x)

limiteSup :: Int
limiteSup = 1000 --Define um limite superior para o maior número

minimo :: Int -> Int -> Int
minimo x y | (x < y) = x
           | otherwise = y

minimoElemento :: Arvore -> Int
minimoElemento Null = limiteSup 
minimoElemento (No n esq dir) = 
    minimo n (minimo (minimoElemento esq) (minimoElemento dir))


    
-- Questão 3 A
profundidadeElemento ::  Arvore -> Int ->Int
profundidadeElemento arv x = (alturaBuscaElemento arv x 0)


-- Usando função auxiliar para fazer a busca
alturaBuscaElemento ::  Arvore -> Int -> Int -> Int
-- Tratando caso base da recursão
alturaBuscaElemento (No n Null Null) b h | (b == n) = h
                                         | otherwise = -1
-- Recursão em si
alturaBuscaElemento (No n esq dir)  b h | (b == n) = h
                                        | otherwise = (max (alturaBuscaElemento esq b (h+1)) (alturaBuscaElemento dir b (h+1))) 
    
-- Fim questão 3 A

-- Questão 3 B
folhasImpares ::  Arvore -> [Int]
-- Caso base
folhasImpares (No n Null Null) = if ((n `mod` 2)  == 1) then [n] else []
-- Tratando arvores com apenas um ramo
folhasImpares (No n Null dir) = (folhasImpares dir)
folhasImpares (No n esq Null) = (folhasImpares esq)
-- Recusão
folhasImpares (No n esq dir) = (folhasImpares esq) ++ (folhasImpares dir)

-- Fim questão 3 B

-- Questão 3 C
-- Contar repetições de elementos na lista
ocorrenciasElemento ::  Arvore -> Int ->Int
ocorrenciasElemento Null i = 0
ocorrenciasElemento (No n esq dir) valor | (valor == n) = 1 + ocorrenciasElemento dir valor + ocorrenciasElemento esq valor 
                                         | otherwise = ocorrenciasElemento dir valor + ocorrenciasElemento esq valor

-- Usamos só para pegar a arvore em uma lista
emOrdem :: Arvore -> [Int]
emOrdem Null = []
emOrdem (No v arvEsq arvDir) = (emOrdem arvEsq) ++ v:[] ++ (emOrdem arvDir)

contains :: [Int] -> Int-> Bool
contains [] _ = False
contains (a:b) n = if (a == n) then True else contains b n

-- Função para remover elementos repetidos de uma lista
removeRepeticoes :: [Int] -> [Int] -> [Int]
removeRepeticoes [] list = list
removeRepeticoes (a:b) list =  if (not (contains list a)) then removeRepeticoes b (list ++ [a]) else removeRepeticoes b list

-- Função auxiliar
auxContagem :: Arvore -> [Int] -> Int -> Int
auxContagem arv [] cont = cont
auxContagem arv (a:b) cont = if ((ocorrenciasElemento arv a) > 1) then (auxContagem arv b (cont+1)) else (auxContagem arv b (cont))

elementosRepetidos ::  Arvore -> Int
elementosRepetidos arv = (auxContagem arv (removeRepeticoes (emOrdem arv) []) 0)

-- Fim questão 3 C
main = do putStrLn (show (somaElementos minhaArvore))
          putStrLn (show (buscaElemento minhaArvore 30))
          putStrLn (show (buscaElemento minhaArvore 55))
          putStrLn (show (minimoElemento minhaArvore))
          putStrLn (show (profundidadeElemento minhaArvore 56))
          putStrLn (show (profundidadeElemento minhaArvore 50))
          putStrLn (show (folhasImpares minhaArvore))
          putStrLn (show (elementosRepetidos minhaArvore))
          putStrLn (show (elementosRepetidos minhaArvoreRep))


