-- Crie uma fun ̧c ̃ao que receba um n ́umerone retorne a fun ̧c ̃ao totiente de Euler (φ(n)).  
-- A fun ̧c ̃ao totientede Euler  ́e dada pelo n ́umero de inteirospositivosra partir de 1 e menores quen, 
-- ou seja 1<=r < n,que s ̃ao coprimos den.  Por exemplo, sen=  10, ent ̃ao os coprimos de 10 de 1 at ́e 
-- 10-1 s ̃ao{1,3,7,9}ea fun ̧c ̃ao deve retornarφ(n) = 4.  Leia n do teclado.


m_coprimos :: Int -> Int -> Bool
m_coprimos a b = if gcd a b == 1 then True else False

totiente :: Int -> [Int]
totiente a = [x | x <- [1..a], coprimos x]
        where 
            coprimos x = m_coprimos x a            

main = do
    putStrLn "n = "
    r <- getLine
    let x = read r :: Int

    print (totiente x)