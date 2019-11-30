## Relatório

### Atividade 3 - INE5413

    Maria Eduarda Hang de Melo
    Thiago Sant' Helena    


Para todas as questões a seguir, utilizamos um arquivo executável separado para cada uma, as instruções de execução destes está contida em cada um deles, visualizável com ```python <arquivo_da_questao>  -h```. Cada algoritmo utilizado para a resolução das questões está implementado no arquivo ```functions.py``` na pasta ```src```.

As representações usadas estão criadas no arquivo ```structures/grafo.py```

#### Questão 1

Implementamos o algoritmo de Edmonds-Karp utilizando um dicionário `F` como função de fluxo sobre os vértices, representando quanto da capacidade daquele arco já foi usada.

A função `bfs` implementada para encontrar caminho aumentantes faz buscas por um caminho onde a diferença entre a capacidade do arco e o valor do vértice no dicionário `F` é maior que 0, além de garantir que o caminho não seja um loop. 

Para a capacidade de cada arco, utilizamos a função `peso` na estrutura já implementada na Atividade 2 (A2).

#### Questão 2

Para implementação do algoritmo de Hopcroft-Karp, primeiramente implementamos uma função `bipartite` para avaliar a possibilidade de bipartir o grafo, e se possível, fazê-lo. Assim, temos os sub-grafos `X` e `Y`.

Utilizamos um dicionário `D` para armazenar as distâncias distâncias encontradas para todo vértice e para o vértice especial `None`. Além disso, utilizando um dicionário `mate` para guardar os pares encontrados.

#### Questão 3

Na implementação do algoritmo de Lawler, tivemos dificuldades e por conta das limitações de tempo não fizemos.


### Anotações gerais sobre as estruturas utilizadas

- As representações utilizadas para os grafos foram as mesmas já criadas para as atividades A1 e A2, com alteração na leitura dos arquivos no construtor para se adaptar aos arquivos .gr
- Utilizamos dicionários na maior parte das estruturas por conta da legibilidade do código, por mais que o desempenho não seja necessariamente o melhor dentre as possibilidades.
