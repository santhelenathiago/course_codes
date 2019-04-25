class (Integral x) => MeuInt x where
    bigger  :: x -> x -> x
    smaller  :: x -> x -> x
    par :: x -> Bool
    impar :: x -> Bool
    primo :: x -> Bool
    mdc ::  x -> x -> x
    (===) :: x -> x -> Bool

    
    bigger a b | a > b = a
               | otherwise = b
               
    smaller a b | a == (bigger a b) = b
                | otherwise = a

    par a = (a `mod` 2) == 0
    
    impar a = (a `mod` 2) == 1

    primo a = null [ x | x <- [2..isqrt a], k `mod` a == 0]

    mdc a b = if b == 0 then a else mdc b (a `mod` b)

    (===) a b = if (abs(a-b) <=q 1) then True else False

                
instance MeuInt Integer
instance MeuInt Int