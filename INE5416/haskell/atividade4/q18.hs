-- Crie uma fun ̧c ̃ao que receba trˆes parˆametros Operador, x e y, e retorne o resultado da opera ̧c ̃ao matem ́aticax 
-- Operador y.  Os operadores poss ́ıveis de informar s ̃ao +, -, *, /.  Leia o Operador, x e y do teclado

operate :: Float -> Char -> Float -> Float
operate a op b | (op == '+') = a + b
               | (op == '-') = a - b
               | (op == '*') = a * b
               | (op == '/') = a / b

main = do
    putStrLn "a = "
    r <- getLine
    let x = read r :: Float

    putStrLn "b = "
    r <- getLine
    let y = read r :: Float

    putStrLn "operador = "
    op <- getChar

    print (operate x op y)