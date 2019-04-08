procuraElemento :: Int -> [Int] -> Bool
procuraElemento _ [] = False
procuraElemento x (a:b) = if (x == a) then True else procuraElemento x b

mesmosElementos :: [Int] -> [Int] -> Bool
mesmosElementos (a:b) [] = True
mesmosElementos l (c:d) = if (procuraElemento c l) then mesmosElementos l d else False


main = do 
    let l1 = [1, 2, 3, 4, 5, 6, 7, 8, 1, 2]
    let l2 = [1, 2, 3, 4, 5, 6, 7, 8]

    print (mesmosElementos l1 l2)