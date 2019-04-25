module Fila (Fila (Queue), enqueue, dequeue, first, emptyQueue) where
    -- Construtor
    data Fila t = Queue [t]
        deriving (Eq,Show)

    -- Retorna a fila com o elemento no último
    enqueue :: Fila t -> t -> Fila t
    enqueue (Queue f) n = Queue (f++[n])

    -- Retorna a fila sem o primeiro elemento
    dequeue :: Fila t -> Fila t
    dequeue (Queue []) = error "Empty"
    dequeue (Queue (first:rest)) = Queue rest

    -- Retorna primeiro elemento da  fila
    first :: Fila t -> t
    first (Queue []) = error "Empty"
    first (Queue (first:rest)) = first

    -- Retorna fila vazia
    emptyQueue :: Fila t
    emptyQueue = (Queue [])

