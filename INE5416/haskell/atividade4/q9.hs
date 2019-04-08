-- Crie uma fun ̧c ̃ao que dados dois pontos no espa ̧co 3D, (x1,  y1,  z1) e (x2,  y2,  z2),  
-- compute a distˆanciaentre eles.  Leia as posi ̧c ̃oes dos pontos do teclado.
dist :: Float -> Float -> Float -> Float -> Float -> Float -> Float
dist x1 y1 z1 x2 y2 z2 = sqrt ((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2)

main = do
    putStrLn "x1 = "
    r <- getLine
    let x1 = read r :: Float

    putStrLn "y1 = "
    r <- getLine
    let y1 = read r :: Float

    putStrLn "z1 = "
    r <- getLine
    let z1 = read r :: Float

    putStrLn "x2 = "
    r <- getLine
    let x2 = read r :: Float

    putStrLn "y2 = "
    r <- getLine
    let y2 = read r :: Float

    putStrLn "z2 = "
    r <- getLine
    let z2 = read r :: Float
    
    print (dist x1 y1 z1 x2 y2 z2)