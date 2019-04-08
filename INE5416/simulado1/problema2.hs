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
               
subArvEsq :: Arvore -> Arvore
subArvEsq (No _ arvEsq _) = arvEsq

subArvDir :: Arvore -> Arvore
subArvDir (No _ _ arvDir) = arvDir    

valorRaiz :: Arvore -> Int
valorRaiz (No v _ _) = v

auxOcorrenciasElemento :: Arvore -> Int -> Int -> Int
auxOcorrenciasElemento Null _ cont = 0
auxOcorrenciasElemento arv valor cont | (valor == (valorRaiz arv)) = 1 + auxOcorrenciasElemento (subArvDir arv) valor (cont+1)


ocorrenciasElemento ::  Arvore -> Int ->Int
ocorrenciasElemento Null i = 0
ocorrenciasElemento arv valor | (valor == valorRaiz arv) = 1 + ocorrenciasElemento (subArvDir arv) valor + ocorrenciasElemento (subArvEsq arv) valor 
                              | otherwise = ocorrenciasElemento (subArvDir arv) valor + ocorrenciasElemento (subArvEsq arv) valor

maioresQueElemento :: Arvore -> Int -> Int
maioresQueElemento Null i = 0
maioresQueElemento arv valor | (valor < valorRaiz arv) = 1 + maioresQueElemento (subArvDir arv) valor + maioresQueElemento (subArvEsq arv) valor 
                             | otherwise = maioresQueElemento (subArvDir arv) valor + maioresQueElemento (subArvEsq arv) valor


subtraiParesImpares ::  Arvore -> Int
subtraiParesImpares Null = 0
subtraiParesImpares arv | (((valorRaiz arv) `mod` 2) == 0) = (valorRaiz arv) + (subtraiParesImpares (subArvEsq arv)) + (subtraiParesImpares (subArvDir arv)) 
                        | otherwise = -(valorRaiz arv) +(subtraiParesImpares (subArvEsq arv)) + (subtraiParesImpares (subArvDir arv))

igual ::  Arvore -> Arvore -> Bool
igual Null Null = True
igual arv1 arv2 | ((valorRaiz arv1) == (valorRaiz arv2)) = (igual (subArvDir arv1) (subArvDir arv2)) && (igual (subArvEsq arv1) (subArvEsq arv2))
                | otherwise = False

altura ::  Arvore -> Int
altura Null = -1
altura (No _ Null Null) = 0
altura arv = 1 + (max (altura (subArvDir arv)) (altura (subArvEsq arv)))

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
menoresQueElemento arv v | ((((valorRaiz arv) `mod` 2) == 0) && (((valorRaiz arv) < v))) = (menoresQueElemento (subArvEsq arv) v) ++ (valorRaiz arv):[] ++ (menoresQueElemento (subArvDir arv) v) 
                         | otherwise = (menoresQueElemento (subArvEsq arv) v) ++ (menoresQueElemento (subArvDir arv) v)

main = do putStrLn (show (somaElementos minhaArvore))
          putStrLn (show (buscaElemento minhaArvore 30))
          putStrLn (show (buscaElemento minhaArvore 55))
          putStrLn (show (minimoElemento minhaArvore))

          print (ocorrenciasElemento minhaArvore 52)

          print (maioresQueElemento minhaArvore 52)

          print (subtraiParesImpares minhaArvore)

          print (igual minhaArvore minhaArvore)

          print (igual minhaArvore minhaArvore2)

          print (altura minhaArvore)

          print (altura minhaArvore2)

          print (folhas minhaArvore)

          print (folhas minhaArvore2)

          print (emOrdem minhaArvore)

          print (menoresQueElemento minhaArvore 65)
          print (menoresQueElemento minhaArvore 30)
