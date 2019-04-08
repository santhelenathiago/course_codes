-- Crie uma fun ̧c ̃ao que resolva uma equa ̧c ̃ao de segundo grau da formaax2+bx+cutilizando a f ́ormulade Bhaskara. 
-- Leia os coeficientes a, b e c do teclado

delta :: Float -> Float -> Float -> Float
delta a b c = b^2 - 4 * a * c

roots :: Float -> Float -> Float -> [Float]
roots a b c = (-b + sqrt (delta a b c))/(2*a) : (-b - sqrt (delta a b c))/(2*a) : []

main = do
    putStrLn "a = "
    r <- getLine
    let x = read r :: Float

    putStrLn "b = "
    r <- getLine
    let y = read r :: Float

    putStrLn "c = "
    r <- getLine
    let z = read r :: Float
    
    print (roots x y z)