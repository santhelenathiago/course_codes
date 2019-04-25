type Ponto2D = (Float, Float)
type Circulo = (Ponto2D, Float)

-- Questão 4 A
dist :: Ponto2D -> Ponto2D -> Float
dist (x1, y1) (x2, y2) = (sqrt ((x1-x2)^2 + (y1-y2)^2))

aux :: Ponto2D -> Ponto2D -> Float -> Bool
aux p1 p2 raio = (dist p1 p2) < raio

dentro ::  Circulo -> [Ponto2D] -> [Ponto2D]
dentro (centro, raio) list = [b | b <- list, aux b centro raio]

-- Fim questão 4 A

-- Questão 4 B

intersec :: Circulo -> Circulo -> Bool
intersec (c1, r1) (c2, r2) = (dist c1 c2) < (r1 + r2)

-- Função para contar interseções a partir de um circulo
countIntersecoes :: [Circulo] -> [Circulo] -> Int
countIntersecoes  [] list = length list
countIntersecoes (c:rest) list = if ((length ([b | b <- list, intersec c b])) == (length list)) 
                                 then 
                                     countIntersecoes rest (list ++ [c])
                                 else
                                     countIntersecoes rest list

-- Listamos a contagem de circulos em conjuntos de circulos que se intersectam a partir de cada circulo
listaIntersecoes :: [Circulo] -> [Int]
listaIntersecoes list = [(countIntersecoes list [b])-1 | b <- list]

-- Função primária
interseccao ::  [Circulo] -> Int
interseccao list = maximum (listaIntersecoes list)

-- Nós recebemos a lista de circulos, e para cada circulo contamos quantas interseções simultâneas
-- encontramos a partir desse circulo, verificando cada outro circulo na lista. Tome por exemplo:
-- [c1, c2, c3, c4] onde c1 se intersecta com c3 e c4, c2 se intersecta com c3, c3 se intersecta com 
-- c1, c4 e c4 se intersecta com c1 e c3. Logo, a lista a partir de c1 será [c1, c3, c4]
--                                                                  c2 será [c2, c3]
--                                                                  c3 será [c3, c1, c4]
--                                                                  c4 será [c4, c1, c3]
-- E tomamos o comprimento da lista de maior comprimento. O retorno de countIntersecoes será
-- [3, 2, 3, 3]. Logo, o máxmimo será 3.

-- Fim questão 4 B

main = do 
    print (dentro ((0, 0), 5) [(1, 1), (0, 1), (0, 2), (0, 3), (0, 6), (5, 5)])
    print (dentro ((0, 0), 5) [(0, 6), (5, 5)])

    print (interseccao [((0, 0), 1), ((1, 0), 1), ((0.5, 0), 1), ((0, -1), 1)])
