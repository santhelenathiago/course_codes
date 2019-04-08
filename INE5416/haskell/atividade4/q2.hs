-- Crie uma fun ̧c ̃ao que receba um n ́umero x, negativo ou positivo, e retorne seu valor absoluto.  Leia x doteclado.

m_abs :: Int -> Int
m_abs n = if n < 0 then -n else n 

main = do
    putStrLn "Valor = "
    r <- getLine
    let n = read r :: Int

    let r = m_abs n
 
    print r

    