main = do 
    putStrLn "a:"
    r <- getLine
    let a = (read r :: Float)
    putStrLn "b:"
    r <- getLine
    let b = (read r :: Float)
    putStrLn "c:"
    r <- getLine
    let c = (read r :: Float)

    let x1 = \a b c -> (-b + (sqrt (b^2 - 4 * a * c)))/(2*a)
    let x2 = \a b c -> (-b - (sqrt (b^2 - 4 * a * c)))/(2*a)

    print (x1 a b c)
    print (x2 a b c)