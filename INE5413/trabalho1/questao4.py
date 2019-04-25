#!/bin/python

from structures.grafo_ponderado import Grafo
from src import functions
from sys import argv
from os import path

def build_path(v, A):
    path = [v]
    n = A[v]

    while n != None:
        path.append(n)
        n = A[n]

    path.reverse()
    return path


if __name__ == '__main__':
    if len(argv) < 3 or argv[1] in ['-h', '--help']:
        print('Uso: python questao1.py <arquivo_descrevendo_grafo> <vertice_inicial>')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()

    v = int(argv[2])

    g = Grafo(filename)

    r, D, A = functions.bellman_ford(g, v)

    if not r:
        print('O programa falhou em encontrar caminhos mínimos!')
        exit()

    for v in D:
        path = build_path(v, A)

        str_path = str(path)[1: -1].replace(' ', '')
        print('{}: {}; d={:.2f}'.format(v, str_path, D[v]))