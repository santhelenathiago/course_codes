data Arvore = Null | No Int Arvore Arvore

minhaArvore :: Arvore
minhaArvore = No 52 (No 32 (No 12 Null Null) (No 35 Null Null)) (No 56 (No 55 Null Null) (No 64 Null Null))

minhaArvore2 :: Arvore
minhaArvore2 = No 52 (No 32 (No 12 Null Null) (No 35 (No 34 Null Null) (No 36 Null Null))) (No 56 (No 75 Null Null) (No 64 Null Null))

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

ocorrenciasElemento ::  Arvore -> Int ->Int
ocorrenciasElemento Null i = 0
ocorrenciasElemento (No v esq dir) valor | (valor == v) = 1 + (ocorrenciasElemento dir valor) + (ocorrenciasElemento esq valor)
                                         | otherwise = (ocorrenciasElemento dir valor) + (ocorrenciasElemento esq valor)

maioresQueElemento :: Arvore -> Int -> Int
maioresQueElemento Null i = 0
maioresQueElemento (No v esq dir) valor | (valor < v) = 1 + maioresQueElemento dir valor + maioresQueElemento esq valor 
                                        | otherwise = (maioresQueElemento dir valor) + (maioresQueElemento esq valor)


subtraiParesImpares ::  Arvore -> Int
subtraiParesImpares Null = 0
subtraiParesImpares (No v esq dir) | ((v `mod` 2) == 0) = v + (subtraiParesImpares esq) + (subtraiParesImpares dir) 
                        | otherwise = -v +(subtraiParesImpares esq) + (subtraiParesImpares dir)

igual ::  Arvore -> Arvore -> Bool
igual Null Null = True
igual (No v1 esq1 dir1) (No v2 esq2 dir2) | (v1 == v2) = (igual dir1 dir2) && (igual esq1 esq2)
                                          | otherwise = False

altura ::  Arvore -> Int
altura Null = -1
altura (No _ Null Null) = 0
altura (No v esq dir) = 1 + (max (altura dir) (altura esq))

folhas ::  Arvore -> Int
folhas Null = 0
folhas (No _ Null Null) = 1
folhas (No _ Null arvDir) = folhas arvDir
folhas (No _ arvEsq Null) = folhas arvEsq
folhas (No _ arvEsq arvDir) = (folhas  arvEsq) + (folhas arvDir)

emOrdem :: Arvore -> [Int]
emOrdem Null = []
emOrdem (No v arvEsq arvDir) = (emOrdem arvEsq) ++ v:[] ++ (emOrdem arvDir)

menoresQueElemento :: Arvore -> Int -> [Int]
menoresQueElemento Null _ = []
menoresQueElemento (No v esq dir) valor | (((v `mod` 2) == 0) && ((v < valor))) = (menoresQueElemento esq valor) ++ v:[] ++ (menoresQueElemento dir valor) 
                         | otherwise = (menoresQueElemento esq valor) ++ (menoresQueElemento dir valor)

quantidade :: Arvore -> Int
quantidade Null = 0
quantidade (No _ esq dir) = 1 + quantidade esq + quantidade dir

mediaElementos :: Arvore -> Float
mediaElementos arv = (fromIntegral (somaElementos arv))/(fromIntegral (quantidade arv))


main = do putStrLn (show (somaElementos minhaArvore))
          putStrLn (show (buscaElemento minhaArvore 30))
          putStrLn (show (buscaElemento minhaArvore 55))
          putStrLn (show (minimoElemento minhaArvore))

          print (ocorrenciasElemento minhaArvore 52)

          print (maioresQueElemento minhaArvore 52)

          print (mediaElementos minhaArvore)

          print (quantidade minhaArvore)
        
