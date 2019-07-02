from copy import deepcopy
from random import choice

def DFS(G):
    # C represent if vertex was visit
    C = dict([(i+1, False) for i, v in enumerate(G.V)])
    # T represents the entering time on vertex
    T = dict([(i+1, float('inf')) for i, v in enumerate(G.V)])
    # F represents the out time on vertex
    F = dict([(i+1, float('inf')) for i, v in enumerate(G.V)])
    # A represents the 
    A = dict([(i+1, None) for i, v in enumerate(G.V)])

    tempo = 0

    for u in G.V.keys():
        if not C[u]:
            tempo = DFS_visit(G, u, C, T, A, F, tempo)

    return (C, T, A, F)

def DFS_adapted(G, Ft):
    # C represent if vertex was visit
    C = dict([(i+1, False) for i, v in enumerate(G.V)])
    # T represents the entering time on vertex
    T = dict([(i+1, float('inf')) for i, v in enumerate(G.V)])
    # F represents the out time on vertex
    F = dict([(i+1, float('inf')) for i, v in enumerate(G.V)])
    # A represents the 
    A = dict([(i+1, None) for i, v in enumerate(G.V)])

    tempo = 0
    keys = [i for i in G.V.keys()]
    keys.sort(key=lambda k: Ft[k], reverse=True)
    for u in keys:
        if not C[u]:
            tempo = DFS_visit(G, u, C, T, A, F, tempo)

    return (C, T, A, F)

def DFS_visit(G, vertex, C, T, A, F, tempo):
    C[vertex] = True
    tempo += 1
    T[vertex] = tempo

    # Iterando atravéis do vizinhos
    for u, val in enumerate(G.matrix[vertex-1]):
        # Offsetting u
        u += 1
        if (not C[u]) and (val != float('inf')):
            A[u] = vertex
            tempo = DFS_visit(G, u, C, T, A, F, tempo)

    tempo += 1
    F[vertex] = tempo

    return tempo

def fortemente_conexas(g):

    C, T, A, F = DFS(g)
    transposed_g = deepcopy(g)
    transposed_g.matrix = [list(i) for i in zip(*g.matrix)]
    print(F)
    Ct, Tt, At, Ft = DFS_adapted(transposed_g, F)

    return At


def DFS_OT(G):
    # C represent if vertex was visit
    C = dict([(i+1, False) for i, v in enumerate(G.V)])
    # T represents the entering time on vertex
    T = dict([(i+1, float('inf')) for i, v in enumerate(G.V)])
    # F represents the out time on vertex
    F = dict([(i+1, float('inf')) for i, v in enumerate(G.V)])

    tempo = 0

    O = list()

    for u in G.V.keys():
        if not C[u]:
            tempo = DFS_visit_OT(G, u, C, T, F, tempo, O)

    return O


def DFS_visit_OT(G, vertex, C, T, F, tempo, O):
    C[vertex] = True
    tempo += 1
    T[vertex] = tempo

    # Iterando atravéis do vizinhos
    for u, val in enumerate(G.matrix[vertex-1]):
        # Offsetting u
        u += 1
        if (not C[u]) and (val != float('inf')):
            tempo = DFS_visit_OT(G, u, C, T, F, tempo, O)

    tempo += 1
    F[vertex] = tempo

    O.insert(0, vertex)

    return tempo


def kruskal(G):

    A = list()

    S = dict([(i+1, set([i+1])) for i, v in enumerate(G.V)])

    # Cria lista de vertices ordenados pelo peso em ordem crescente
    E = [(u, v) for u in G.V for v in G.V if G.matrix[u-1][v-1] != float('inf')]
    E.sort(key=lambda k: G.matrix[k[0]-1][k[1]-1])
    

    for u, v in E:
        if S[u] is not S[v]:
            A.append((u, v))
            x = set.union(S[u], S[v])
            
            
            for w in x:
                S[w] = x

    return A

