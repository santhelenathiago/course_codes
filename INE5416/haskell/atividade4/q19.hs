-- A conjetura de Goldbach diz que todo n ́umero inteiro par maior que 2 pode ser expressado como a soma dedois n ́umeros primos.  
-- Embora ela nunca foi provada ser verdadeira, ela funciona para n ́umeros grandes.
-- Por  exemplo,  podemos  escrever  o  n ́umero  14  como  a  soma  de  7  e  7,  ou  18  como  a  soma  de  5  e  13.
-- Implemente uma fun ̧c ̃ao que receba um n ́umero n como parˆametro e retorne um dos n ́umeros primos quefazem parte da soma.  
-- Ex:  retorne 5 ou 13 para o caso do n ́umero 18.  Leia n do teclado

is_prime :: Int -> Bool
is_prime n | (n <= 3) = n>  1
           | (n `mod` 2 == 0 || n `mod` 3 == 0) = False
           | otherwise = prime_comp n 5

prime_comp :: Int -> Int -> Bool
prime_comp n i | (i*i > n) = True
               | otherwise = if ((n `mod` i) == 0 || (n `mod` (i + 2)) == 0) then False else prime_comp n (i+6)

next_prime :: Int -> Int
next_prime n = if (is_prime n) then n else (next_prime (n+1))

goldbach :: Int -> Int
goldbach n | (n `mod` 2 /= 0) = -1
           | otherwise = next_prime(n `quot` 2)
 
main = do
    putStrLn "n = "
    r <- getLine
    let n = read r :: Int
                
    print (goldbach n)