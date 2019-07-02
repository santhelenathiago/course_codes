from structures.grafo import GrafoD
from src.functions import *
from sys import argv
from os import path

if __name__ == '__main__':
    if len(argv) < 2 or argv[1] in ['-h', '--help']:
        print('Uso: python questao2.py <arquivo_descrevendo_grafo>')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()

    g = GrafoD(filename)

    O = DFS_OT(g)

    print(g.rotulo(O[0]), end='')
    for u in O[1:]:
        print(' → {}'.format(g.rotulo(u)), end='')
    print()