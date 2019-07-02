from structures.grafo import GrafoD
from src.functions import *
from sys import argv
from os import path

if __name__ == '__main__':
    if len(argv) < 2 or argv[1] in ['-h', '--help']:
        print('Uso: python questao3.py <arquivo_descrevendo_grafo>')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()

    g = GrafoD(filename)

    A = kruskal(g)


    # Printa soma dos pesos
    print(sum([g.matrix[u-1][v-1] for u, v in A]))
    print('{}-{}'.format(A[0][0], A[0][1]), end='')
    for u, v in A[1:]:
        print(', {}-{}'.format(u, v), end='')
    print()


