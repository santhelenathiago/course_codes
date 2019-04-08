-- Crie uma fun ̧c ̃ao que receba dois n ́umeros x e y e retorne o m ́aximo divisor comum (DICA: pesquise sobreo Algoritmo de Euclides).  
-- Leia x e y do teclado
-- min :: Int -> Int -> Int
-- min a b = if a > b then b else a

-- max :: Int -> Int -> Int
-- max a b = if a > b then a else b

my_gcd :: Int -> Int -> Int
my_gcd a b = if b == 0 then a else my_gcd b (a `mod` b)

main = do
    putStrLn "a = "
    r <- getLine
    let x = read r :: Int
    putStrLn "b = "
    r <- getLine
    let y = read r :: Int

    print (my_gcd (max x y) (min x y))