-- Crie uma fun ̧c ̃ao que receba um n ́umero n e retorne se o mesmo  ́e primo.  Leia n do teclado.

is_prime :: Int -> Bool
is_prime n | (n <= 3) = n>  1
           | (n `mod` 2 == 0 || n `mod` 3 == 0) = False
           | otherwise = prime_comp n 5

prime_comp :: Int -> Int -> Bool
prime_comp n i | (i*i > n) = True
               | otherwise = if ((n `mod` i) == 0 || (n `mod` (i + 2)) == 0) then False else prime_comp n (i+6)
 

main = do
    putStrLn "n = "
    r <- getLine
    let x = read r :: Int

    print (is_prime x)