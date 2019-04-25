module Main(main) where

import Arvores

minhaArvore :: Arvore
minhaArvore = No 52 (No 32 (No 12 Null Null) (No 35 Null Null)) (No 56 (No 55 Null Null) (No 64 Null Null))

minhaArvore2 :: Arvore
minhaArvore2 = No 52 (No 32 (No 12 Null Null) (No 35 (No 34 Null Null) (No 36 Null Null))) (No 56 (No 75 Null Null) (No 64 Null Null))
    

main = do 
    putStrLn (show (somaElementos minhaArvore))
    putStrLn (show (buscaElemento minhaArvore 30))
    putStrLn (show (buscaElemento minhaArvore 55))
    putStrLn (show (minimoElemento minhaArvore))

    print (ocorrenciasElemento minhaArvore 52)

    print (maioresQueElemento minhaArvore 52)

    print (mediaElementos minhaArvore)

    print (quantidade minhaArvore)