-- Fixity declarations servem para definir a ordem em que operadores serão resolvidos, classificando
-- operadores com nível de 0 a 9, sendo 9 o que mais posterta a resoolução e 0 o que menos.
-- Além disso, os operadores se classificam em infixr (se resolve da direita para esquerda), infixl 
-- (se resolve da esquerda para a direita) ou infix (indiferente)

-- Exemplos
import Examples

main = do
    print  ((Test "1") >: (Test "2") >: (Test "4"))
    print  ((Test "1") <: (Test "2") <: (Test "4"))
    -- Para esse caso, precisamos utilizar parenteses para epxlicitar a ordem de
    -- resolução, do contrário, o programa não compila e indica um erro 
    -- (descomente a linha sem parenteses para averiguar)
    print  ((Test "1") ?: (  (Test "2") ?: (Test "4")  )  )
    -- print  ((Test "1") ?: (Test "2") ?: (Test "4"))


