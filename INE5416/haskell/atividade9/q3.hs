main = do 
    let fib = \n -> if (n == 0 || n == 1) then 1 else (fib (n-1)) + (fib (n-2))
    
    putStrLn "N ="
    r <- getLine
    let n = (read r :: Float)

    print (fib n)
