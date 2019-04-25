main = do 
    putStrLn "Nota 1:"
    r <- getLine
    let n1 = (read r :: Float)
    putStrLn "Nota 2:"
    r <- getLine
    let n2 = (read r :: Float)
    putStrLn "Nota 3:"
    r <- getLine
    let n3 = (read r :: Float)

    print ((\x y z -> (if (((x+y+z)/3) >= 6) then "Aprovado" else "Reprovado")) n1 n2 n3)