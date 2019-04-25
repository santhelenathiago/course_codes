sum_odds :: Int -> Int
sum_odds 1 = 1
sum_odds n | ((n `mod` 2) == 1) = n + (sum_odds (n-1))
           | otherwise = (sum_odds (n-1))


main = do
    let l = [1..10]
    print (sum_odds 10)