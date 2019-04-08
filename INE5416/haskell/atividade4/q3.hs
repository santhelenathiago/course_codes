-- Crie uma fun ̧c ̃ao que receba a base e a altura de um triˆangulo e calcule a  ́area do mesmo.  Leia a base e aaltura do teclado.

area_triangulo :: Float -> Float -> Float
area_triangulo base altura = (base * altura) / 2 

main = do
    putStrLn "Base = "
    r <- getLine
    let b = read r :: Float

    putStrLn "Altura = "
    r <- getLine
    let h = read r :: Float

    print ("Area do triangulo = " ++ (show (area_triangulo h b)))
