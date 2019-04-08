-- Crie uma fun ̧c ̃ao que receba dois n ́umeros x e y e determine se eles s ̃ao coprimos.  
-- Dois n ́umeros s ̃ao ditoscoprimos se o m ́aximo divisor comum entre eles  ́e 1.  Leia x e y do teclado.

my_gcd :: Int -> Int -> Int
my_gcd a b = if b == 0 then a else my_gcd b (a `mod` b)

coprimos :: Int -> Int -> String
coprimos a b = if my_gcd a b == 1 then "Coprimos" else "Nope"

main = do
    putStrLn "a = "
    r <- getLine
    let x = read r :: Int
    putStrLn "b = "
    r <- getLine
    let y = read r :: Int

    print (coprimos x y)