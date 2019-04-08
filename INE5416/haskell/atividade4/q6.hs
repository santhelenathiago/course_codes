{- Crie  uma  fun ̧c ão  que  receba  três  inteiros  x,  y  e  z  e  retorne  se  havendo  varetas 
 com  esses  valores  emcomprimento  pode-se  construir  um  triângulo.   Exemplo,  com  varetas  de  
 comprimento  4,  8  e  9  possoconstruir um triângulo, porém com varetas de comprimento 10, 5 e 4 
 n ̃ao posso construir um triˆangulo.Leia x, y e z do teclado -}

possivel_triangulo :: Int -> Int -> Int -> String
possivel_triangulo a b c = if (abs (b - c)) < a && a < (b+c) ||
                              (abs (a - c)) < b && b < (a+c) || 
                              (abs (a - b)) < c && c < (a+b)
                            then 
                                "Possivel" 
                            else 
                                "Impossivel"


main = do
    putStrLn "Medida 1 = "
    r <- getLine
    let x = read r :: Int

    putStrLn "Medida 2 = "
    r <- getLine
    let y = read r :: Int

    putStrLn "Medida 3 = "
    r <- getLine
    let z = read r :: Int


    print (possivel_triangulo x y z)
    

