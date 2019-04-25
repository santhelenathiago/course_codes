main = do 
    putStrLn "a:"
    r <- getLine
    let a = (read r :: Int)
    putStrLn "b:"
    r <- getLine
    let b = (read r :: Int)
    putStrLn "c:"
    r <- getLine
    let c = (read r :: Int)

    print ((\x y z -> if (x > y) then if (x > z) then x else z else if (y > z) then y else z ) a b c)