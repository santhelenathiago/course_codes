-- Crie  uma  fun ̧c ̃ao  que  receba  trˆes  n ́umeros  x,  y  e  z  e  retorne  o  m ́aximo  divisor  comum  
-- (DICA:  apenasmodifique o algoritmo anterior).  Leia x, y e z do teclado

my_gcd :: Int -> Int -> Int
my_gcd a b = if b == 0 then a else my_gcd b (a `mod` b)


main = do
    putStrLn "a = "
    r <- getLine
    let x = read r :: Int
    putStrLn "b = "
    r <- getLine
    let y = read r :: Int
    putStrLn "c = "
    r <- getLine
    let z = read r :: Int

    let t = (my_gcd (max x y) (min x y))

    print (my_gcd (max t z) (min t z))