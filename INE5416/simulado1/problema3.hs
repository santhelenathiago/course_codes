type Ponto = (Float, Float)

distanciaEnorme :: Float
distanciaEnorme = 10000

colineares :: Ponto -> Ponto -> Ponto -> Bool
colineares (x1, y1) (x2, y2) (x3, y3) = (x1*y2 + x3*y1 + x2*y3 - x3*y2 - x1*y3 - x2*y1) == 0

distancia :: Ponto -> Ponto -> Float
distancia (x1, y1) (x2, y2) = (sqrt ((x1-x2)**2 + (y1-y2)**2))

encontraMenorDistancia :: Ponto -> [Ponto] -> Float -> Float
encontraMenorDistancia p [] min = min
encontraMenorDistancia p (a:b) min = if ((distancia p a) < min) then 
                                        encontraMenorDistancia p b (distancia p a)
                                      else
                                        encontraMenorDistancia p b min
     
comparaMenoresDistancias :: [Ponto] -> Float -> Float
comparaMenoresDistancias [] min = min
comparaMenoresDistancias (a:b) min = if ((encontraMenorDistancia a b min) < min) then
                                        (comparaMenoresDistancias b (encontraMenorDistancia a b min))
                                    else
                                        (comparaMenoresDistancias b min)

menorDistancia ::  [Ponto] -> Float
menorDistancia l = comparaMenoresDistancias l distanciaEnorme

main = do 
    print (colineares (0, 0) (1, 1) (2, 2))
    print (colineares (0, 0) (1, 1) (2, 4))

    print (menorDistancia [(0, 0), (1, 1), (2, 10), (2, 4), (5, 5)])


-- Comentário questão 3 B:
-- Separei a função em 3 partes, uma "iterativa", para comparar a menor distância de 
-- (cada elemento com todos os demais) com a distância de (cada outro com todos os demais) da lista. 
-- A segunda função encontra a menor distância entre um elemento específico e todos os outros, usada pela
-- primeira função. Outro ponto válido da função é que evitei comparações repetidas comparando
-- cada elemento apenas com os posteriores a ele na ordem da lista