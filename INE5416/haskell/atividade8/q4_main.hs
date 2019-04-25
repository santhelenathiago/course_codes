module Main(main) where
    import Fila

    myQueue :: Fila Integer
    myQueue = enqueue (enqueue emptyQueue 2) 3

    main = do
        print myQueue
        print (enqueue myQueue 1)
        print (first (enqueue myQueue 1))
        print (dequeue (enqueue myQueue 1))
        

    