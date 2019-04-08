-- Crie uma fun ̧c ̃ao que receba dois n ́umeros x e y e retorne se x  ́e divis ́ıvel por y.  Leia x e y do teclado.

divisible :: Int -> Int -> Bool
divisible a b = if a `mod` b == 0 then True else False

main = do
    putStrLn "a = "
    r <- getLine
    let x = read r :: Int
    putStrLn "b = "
    r <- getLine
    let y = read r :: Int

    print (divisible x y)