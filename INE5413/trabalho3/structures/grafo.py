class GrafoNDP:
    """
        Grafo ponderado e não dirigido
    """
    def __init__(self, file, not_connected=float('inf')):
        '''
            deve carregar um grafo a partir de um arquivo no formato especificado
        '''
        
        self.not_connected = not_connected

        self._s = None
        self._t = None
        
        # Matrix de pesos e conexões
        self.matrix = list()

        # Lista de rotulos de vertices
        self.V = dict()

        # Contador de arestas
        self._a = 0

        with open(file) as f:
            matrix_created = False

            for row in f:

                # Remove quebras de linha
                s = row.replace('\n', '')
                # Separa em espaços
                s = s.split()

                if not s:
                    # skip empy lines
                    continue

                if s[0] == 'c':
                    # Comentário
                    continue

                elif s[0] == 'p':
                    # Configurando

                    self._a = int(s[3])

                    num_vertices = int(s[2])

                    for i in range(num_vertices):
                        self.V[i+1] = i+1
                        
                        self.matrix.append([not_connected 
                                            for _ in range(num_vertices)])

                    matrix_created = True

                elif s[0] == 'n':
                    if s[2] == 's':
                        self._s = int(s[1])

                    elif s[2] == 't':
                        self._t = int(s[1])

                elif s[0] == 'e' and matrix_created:
                    # Entrada de aresta
                    e1 = int(s[1]) - 1
                    e2 = int(s[2]) - 1

                    try:
                        weight = int(s[3])

                    except IndexError:
                        weight = 1 if not_connected == float('inf') else float('int')

                    self.matrix[e1][e2] = weight
                    self.matrix[e2][e1] = weight

    @property
    def s(self):
        if self._s is None:
            return 1

        else:
            return self._s

    @property
    def t(self):
        if self._t is None:
            return max(self.V)

        else:
            return self._t
                
                
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


class GrafoD:
    """
        Grafo dirigido e ponderado
    """
    def __init__(self, file, not_connected=float('inf')):
        '''
            deve carregar um grafo a partir de um arquivo no formato especificado
        '''

        self.not_connected = not_connected

        self._s = None
        self._t = None
        
        # Matrix de pesos e conexões
        self.matrix = list()

        # Lista de rotulos de vertices
        self.V = dict()

        # Contador de arestas
        self._a = 0

        with open(file) as f:
            matrix_created = False

            for row in f:
                # Remove quebras de linha
                s = row.replace('\n', '')
                # Separa em espaços
                s = s.split()

                if not s:
                    # skip empy lines
                    continue

                if s[0] == 'c':
                    # Comentário
                    continue

                elif s[0] == 'p':
                    # Configurando

                    self._a = int(s[3])

                    num_vertices = int(s[2])

                    for i in range(num_vertices):
                        self.V[i+1] = i+1
                        
                        self.matrix.append([not_connected 
                                            for _ in range(num_vertices)])

                    matrix_created = True

                elif s[0] == 'n':
                    if s[2] == 's':
                        self._s = int(s[1])

                    elif s[2] == 't':
                        self._t = int(s[1])

                elif s[0] == 'a' and matrix_created:
                    # Entrada de arco
                    e1 = int(s[1]) - 1
                    e2 = int(s[2]) - 1

                    try:
                        weight = int(s[3])

                    except IndexError:
                        weight = 1 if not_connected == float('inf') else float('int')

                    self.matrix[e1][e2] = weight

    @property
    def s(self):
        if self._s is None:
            return 1

        else:
            return self._s

    @property
    def t(self):
        if self._t is None:
            return max(self.V)

        else:
            return self._t
                
    def view_of_E(self):
        view = list()
        for i, row in enumerate(self.matrix):
            for j, value in enumerate(row):
                # Faz checar apenas abaixo da diagonal principal, já
                # que o grafo é não-orientado
                if j >= i:
                    break

                # Se i e j estão conectados
                if value != self.not_connected:
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
        return [a != self.not_connected for a in self.matrix[v]].count(True)

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
            if e != self.not_connected:
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
        return self.matrix[u][v] != self.not_connected

    def print_graph(self):
        for row in self.matrix:
            print(row)

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

        return self.matrix[u][v]