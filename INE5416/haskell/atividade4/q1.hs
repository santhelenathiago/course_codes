-- Crie uma fun ̧c ̃ao que receba dois n ́umeros x e y e retornexy.  Leia x e y do teclado.

main = do
    putStrLn "X = "
    r <- getLine
    let x = (read r :: Int)
    putStrLn "Y = "
    r <- getLine
    let y = (read r :: Int)
    let result = x ^ y
    print ("X ^ Y = " ++ show result )
    