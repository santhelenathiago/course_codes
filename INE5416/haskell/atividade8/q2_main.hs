module Main(main) where

import Ponto
    
p1 :: Ponto
p1 = (Ponto2D (0, 0))

p2 :: Ponto
p2 = (Ponto2D (1, 0))


p3 :: Ponto
p3 = (Ponto2D (1, 1))

main = do
    print (distancia p1 p2)
    print (colineares p1 p2 p3)
    print (formaTriangulo p1 p2 p3)