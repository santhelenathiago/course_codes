-- Crie uma fun ̧c ̃ao que receba dois n ́umeros x e y e retorne o m ́ınimo m ́ultiplo comum 
-- (DICA: use a fun ̧c ̃aodo m ́aximo divisor comum j ́a criada).  Leia x e y do teclado

my_gcd :: Int -> Int -> Int
my_gcd a b = if b == 0 then a else my_gcd b (a `mod` b)


my_lcm :: Int -> Int -> Int
my_lcm a b = (abs (a*b)) `div` (my_gcd a b) 

main = do
    putStrLn "a = "
    r <- getLine
    let x = read r :: Int
    putStrLn "b = "
    r <- getLine
    let y = read r :: Int

    print (my_lcm (max x y) (min x y))