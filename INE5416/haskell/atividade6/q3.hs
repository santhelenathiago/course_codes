-- Crie um novo tipo Ponto, usandodata, que pode ser um ponto 2D ou um ponto 3D. 
-- Depois, crie umafun ̧c ̃ao que receba dois pontos (necessariamente ambos sendo 2D ou 
-- ambos sendo 3D), e retorne a distˆanciaentre eles

data Ponto = Ponto2D Float Float | Ponto3D Float Float Float

dist :: Ponto -> Ponto -> Float
dist (Ponto2D x1 y1) (Ponto2D x2 y2) = sqrt ((x1 - x2)^2 + (y1 - y2)^2)
dist (Ponto3D x1 y1 z1) (Ponto3D x2 y2 z2) = sqrt ((x1 - x2 - z1)^2 + (y1 - y2 - z2)^2)

main = do
    print (dist (Ponto2D 0 0) (Ponto2D 5 5))
    print (dist (Ponto3D 0 0 0) (Ponto3D 5 5 5))