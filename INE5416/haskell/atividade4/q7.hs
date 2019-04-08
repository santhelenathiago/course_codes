-- Crie uma fun ̧c ̃ao que compute o n- ́esimo n ́umero de Fibonacci.  Leia n do teclado
fib :: Int -> Int
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)


main = do
    putStrLn "N = "
    r <- getLine
    let n = read r :: Int

    print (fib n)