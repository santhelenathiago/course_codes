-- Crie uma fun ̧c ̃ao que receba 3 valores num ́ericos (a, b, c) e retorne o maior deles.  
-- N ̃ao utilize nenhumaforma de ordena ̧c ̃ao.  Leia os valores a, b, c do teclado

greater_two :: Int -> Int -> Int
greater_two a b = if a > b then a else b

greater_three :: Int -> Int -> Int -> Int
greater_three a b c = greater_two c (greater_two a b)

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
    
    print (greater_three x y z)