-- Crie uma fun ̧c ̃ao que receba dois valores booleanos (x, y) retorne o resultado do “ou exclusivo” (XOR)sobre eles.  A fun ̧c ̃ao apenas deve usar os operadores&&,||enot.  Leia os valores x e y do teclado.

xor :: Bool -> Bool -> Bool
xor x y = (not x && y) || (x && not y)

main = do
    putStrLn "Bool X = "
    r <- getLine
    let x = read r :: Bool

    putStrLn "Bool Y = "
    r <- getLine
    let y = read r :: Bool

    print ("XOR X Y = " ++ (show (xor x y)))
