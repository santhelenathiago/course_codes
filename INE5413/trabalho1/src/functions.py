def bfs(G, s):
    assert s in G.V.keys()
    # Normalizando para 0-based
    s -= 1

    C = dict([(i, False) for i, v in enumerate(G.V)])
    D = dict([(i, float('inf')) for i, v in enumerate(G.V)])
    A = dict([(i, None) for i, v in enumerate(G.V)])

    C[s] = True
    D[s] = 0

    Q = list()
    Q.append(s)
    while len(Q) != 0:
        u = Q.pop(0)
        for v in [i for i, _ in enumerate(G.matrix[u]) if _ != float('inf')]:
            if not C[v]:
                C[v] = True
                D[v] = D[u] + 1
                A[v] = u
                Q.append(v)
    
    return (dict([(k+1, D[k]) for k in D]),
            dict([(k+1, A[k]) for k in A])) 

def hierholzer(G):
        C = dict([(v, False) for v in G.view_of_E()])

        v = list((G.V.keys()))[0]

        r, cicle = search_subcicle(G, v, C)

        if r is False:
            return (False, None)

        if all([i for i in C.values()]):
            return (True, cicle)

        else:
            return (False, None)

        


def search_subcicle(G, v, C):
    cicle = []
    t = v
    cicle.append(v)

    while True:
        # Checa se v ainda tem vizinhos
        # E se tiver, já pega o primeiro que achou e vai
        have_neighboor = False
        for i, p in enumerate(G.matrix[v-1]):
            if p != float('inf'):
                if (v, i+1) in C.keys():
                    if not C[(v, i+1)]:
                        have_neighboor = True
                        C[(v, i+1)] = True
                        v = i + 1
                        break

                elif (i+1, v) in C.keys():
                    if not C[(i+1, v)]:
                        have_neighboor = True
                        C[(i+1, v)] = True
                        v = i + 1
                        break

        if not have_neighboor:
            return (False, None)            

        cicle.append(v)
        if v == t:
            break

    # Se tem alguma aresta não visitada em C, encontra ela e chama a função novamente
    if not all(C.values()):
        v = [k[0] for k in C.keys() if not C[k]][0]

        r, cicle_b = search_subcicle(G, v, C)

        # Se a função não encontra mais um ciclo
        if not r:
            return (False, None)

        # Se encotrou, tenta inserir o ciclo encontrado 
        # no anterior para retornar, e não achar, identifica
        # que são ciclos separados, portanto, não eulerianos, 
        # e retorna false
        found = False
        for i, v in enumerate(cicle_b):
            if v in cicle:
                found = True
                
                cicle_b = [*cicle_b[i:-1], *cicle_b[:i], v]

                index = cicle.index(cicle_b[0])
                cicle = [*cicle[:index], *cicle_b[:-1], *cicle[index:]]
                break


        if not found:
            return (False, None)

    return (True, cicle)

def bellman_ford(G, s):
    # Inicialização
    D = dict([(i+1, float('inf')) for i, v in enumerate(G.V)])
    A = dict([(i+1, None) for i, v in enumerate(G.V)])

    D[s] = 0
    # relaxamento
    for _ in G.V:
        for e in G.view_of_E():
            if D[e[1]] > D[e[0]] + G.matrix[e[0]-1][e[1]-1]:
                D[e[1]] = D[e[0]] + G.matrix[e[0]-1][e[1]-1]

                A[e[1]] = e[0]

        for e in G.view_of_E():
            if D[e[0]] > D[e[1]] + G.matrix[e[1]-1][e[0]-1]:
                D[e[0]] = D[e[1]] + G.matrix[e[1]-1][e[0]-1]

                A[e[0]] = e[1]
    
    for e in G.view_of_E():
        if D[e[1]] > D[e[0]] + G.matrix[e[0]-1][e[1]-1]:
            return (False, None, None)

    for e in G.view_of_E():
        if D[e[0]] > D[e[1]] + G.matrix[e[1]-1][e[0]-1]:
            return (False, None, None)

    return (True, D, A)
    