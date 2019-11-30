from copy import deepcopy
from random import choice
import itertools



def bipartite(g):
    '''
        @param g  grafo a ser avaliado

        @return (is_bipartitable, X, Y)  onde X e Y são listas de vertices
    '''

    # Inicializa as listas, sendo que X já tem um primeiro
    # vértice
    X = []
    Y = []
    all_vertexes = list(g.V.keys())
    while len(all_vertexes) > 0:
        # Pega um vértice qualquer do grafo
        s = all_vertexes.pop()
        X.append(s)

        # Pega os vizinhos desse nodo
        neighs_of_s = g.vizinhos(s)
        to_remove = []
        for n in neighs_of_s:
            neighs_of_n = g.vizinhos(n)
            for m in neighs_of_s:
                # jump the same
                if m == n:
                    continue

                if m in neighs_of_n:
                    return (False, None, None)

            Y.append(n)
            to_remove.append(n)

        # print(f"s = {s} ---- neighs = {neighs_of_s}")
        # print(f"all_vertexes = {all_vertexes}")
        # print(f"to_remove = {to_remove}")

        for t in to_remove:
            if t in all_vertexes:
                all_vertexes.remove(t)

    return (True, X, list(set(Y)))


def hopcroft_karp(G):
    b, X, Y = bipartite(G)

    if not b:
        return (0, "Failure")

    D = dict([(i+1, float('inf')) for i, v in enumerate(G.V)])
    D[None] = float('inf')

    mate = dict([(i+1, None) for i, v in enumerate(G.V)])

    m = 0

    while BFS_hopcroft_karp(G, mate, D):
        for x in X:
            if mate[x] is None:
                if DFS_hopcroft_karp(G, mate, x, D):
                    m += 1


    return (m, mate)


def BFS_hopcroft_karp(G, mate, D):
    b, X, Y = bipartite(G)

    if not b:
        return (0, "Failure")

    Q = []
    for x in X:
        if mate[x] is None:
            D[x] = 0
            Q.append(x)

        else:
            D[x] = float('inf')

    D[None] = float('inf')

    while len(Q) > 0:
        x = Q.pop(0)

        if D[x] < D[None]:
            for y in G.vizinhos(x):
                if D[mate[y]] == float('inf'):
                    D[mate[y]] = D[x] + 1
                    Q.append(mate[y])

    return D[None] != float('inf')

def DFS_hopcroft_karp(G, mate, x, D):

    if x != None:
        for y in G.vizinhos(x):
            if D[mate[y]] == D[x]+1:
                if DFS_hopcroft_karp(G, mate, mate[y], D):
                    mate[y] = x
                    mate[x] = y

                    return True

        D[x] = float('inf')

        return False
    
    return True
    

def edmonds_karp(G, source, sink):
    n = len(G.V)
    F = dict([((u, v), 0) for u in G.V.keys() for v in G.V.keys()])
    # residual capacity from u to v is C[u][v] - F[u][v]

    while True:
        path = bfs(G, F, source, sink)
        if not path:
            break

        u,v = path[0], path[1]
        flow = G.peso(u, v) - F[(u, v)]
        for i in range(len(path) - 2):
            u, v = path[i+1], path[i+2]
            flow = min(flow, G.peso(u, v) - F[(u, v)])

        for i in range(len(path) - 1):
            u,v = path[i], path[i+1]
            F[(u, v)] += flow
            F[(v, u)] -= flow

    return sum([F[(source, i)] for i in range(1, n+1)])

def bfs(G, F, source, sink):
    P = dict([(i+1, None) for i, v in enumerate(G.V)])
    P[source] = source
    queue = [source]
    while len(queue) > 0:
        u = queue.pop(0)
        for v in G.vizinhos(u):
            if G.peso(u, v) - F[(u, v)] > 0 and P[v] is None:
                P[v] = u
                queue.append(v)
                if v == sink:
                    path = []
                    while True:
                        path.insert(0, v)
                        if v == source:
                            break
                        v = P[v]
                    return path
    return None

def list_of_combs(arr):
    combs = []
    for i in range(0, len(arr)+1):
        listing = [list(x) for x in itertools.combinations(arr, i)]
        combs.extend(listing)
    return combs
        
        

# def lawler(G):
#     X = [None] * 2**len(G.V)
#     X[0] = 0
#     Ss = list_of_combs(G.V.keys())

#     for S in Ss:
#         s = f(S)
#         X[s] = float('inf')
#         Gt = 
