from structures.grafo import GrafoNDP as Grafo
from src.functions import bipartite
if __name__ == '__main__':
    g = Grafo('grafo_simples.net')
    print(bipartite(g))