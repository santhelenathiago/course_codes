fritz :: Int -> Int
fritz n | (n == 0) = 0
        | (n == 1) = 1
        | otherwise = (fritz (n-1)) + 3 * (fritz (n-2))


main = do
    print (fritz 10)