-- A diferença entre newtype e data, é que newtype aceita estritamente um construtor com estritamente um 
-- campo. newtype pode ser substituido por data e ainda compilar, no entanto o contrário não é verdade por
-- conta da restrição. Além disso, newtype pode corresponder em tempo de execução ao que este armazena. 
-- Type por outro lado funciona mais como uma renomeação para algum tipo, o compilador esencialmente
-- esquece dele após executar as substituições

-- Exemplo:
type Valor = Float

-- Aqui, podemos usar Valor como um alias para Float

data Valor = Valor1 Float | Valor2 Float Float

-- Assim, Valor tem essencialmente duas formas. Aqui não podemos substituir data por newtype

data Valor = Valor1 Float
-- Aqui no entanto, podemos


newtype Valor = Valor Float
-- Assim, valor funcionalmente será um alias para Float também