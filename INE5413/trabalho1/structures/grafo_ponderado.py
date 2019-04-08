class Grafo:
    def __init__(self, file):
        '''
            deve carregar um grafo a partir de um arquivo no formato especificado
        '''

        # Matrix de pesos e conexões
        self.matrix = list()

        # Lista de rotulos de vertices
        self.V = dict()

        # Contador de arestas
        self._a = 0

        with open(file) as f:
            in_vertices = False
            in_edges = False
            num_vertices = 0

            for row in f:
                # Remove quebras de linha
                s = row.replace('\n', '')
                # Separa em espaços
                s = s.split()

                if s[0] == '*vertices':
                    in_vertices = True
                    num_vertices = int(s[1])
                    for _ in range(num_vertices):
                        self.matrix.append([float('inf') for 
                                       __ in range(num_vertices)])
                    continue

                elif s[0] == '*edges':
                    in_vertices = False
                    in_edges = True
                    continue

                elif s[0][0] == '#':
                    continue

                if in_vertices:
                    self.V[int(s[0])] = s[1]

                if in_edges:
                    # Normaliza para 0-indexed, para ter coerência
                    # com a matrix armazenada
                    v = int(s[0])-1
                    u = int(s[1])-1

                    p = float(s[2])

                    self.matrix[v][u] = p
                    self.matrix[u][v] = p

                    self._a += 1
                
    def view_of_E(self):
        view = list()
        for i, row in enumerate(self.matrix):
            for j, value in enumerate(row):
                # Faz checar apenas abaixo da diagonal principal, já
                # que o grafo é não-orientado
                if j >= i:
                    break

                # Se i e j estão conectados
                if value != float('inf'):
                    view.append((i+1, j+1))

        return view
                

    def qtdArestas(self):
        '''
             @return a quantidade de arestas;
        '''
        return self._a

    def qtdVertices(self):
        '''
             @return a quantidade de vértices;
        '''
        return len(self.V)

    def grau(self, v):
        '''
            @return o grau do vértice v;
        '''
        assert v in self.V.keys()

        # Normaliza para 0-indexed
        v -= 1
        return [a != float('inf') for a in self.matrix[v]].count(True)

    def rotulo(self, v):
        '''
            @return o rótulo do vértice v;
        '''
        assert v in self.V.keys()
        return self.V[v]


    def vizinhos(self, v):
        '''
            @return vizinhos do vértice v;
        '''
        assert v in self.V.keys()
        # Normaliza para 0-indexed
        v -= 1
        n = list()
        for i, e in enumerate(self.matrix[v]):
            if e != float('inf'):
                n.append(i+1)

        return n

    def haAresta(self, u, v):
        '''
            @return se {u, v} ∈ E, verdadeiro; se não existir, falso;
        '''
        assert v in self.V.keys()
        assert u in self.V.keys()
        # Normaliza para 0-indexed
        u -= 1
        v -= 1
        return self.matrix[v][u] != float('inf')
        

    def peso(self, u, v):
        '''
            @return se {u,v} ∈ E, retorna o peso da aresta {u, v}; se não existir,
            retorna um valor infinito positivo;
        '''
        assert v in self.V.keys()
        assert u in self.V.keys()
        # Normaliza para 0-indexed
        u -= 1
        v -= 1

        return self.matrix[v][u]

    def print_graph(self):
        for row in self.matrix:
            print(row)

