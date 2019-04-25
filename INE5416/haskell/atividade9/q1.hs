
main = do
    let f = \a b -> (not (a && b)) && (a || b)
    print (f True False)
    print (f False True)
    print (f True True)
    print (f False False)