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

def path_len(path, g, v):
    d = 0
    for u, v in zip(path[:-1], path[1:]):
        d += g.matrix[u-1][v-1]

    return d
    

if __name__ == '__main__':
    if len(argv) < 3:
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

        d = path_len(path, g, v)
        str_path = str(path)[1: -1].replace(' ', '')
        print('{}: {}; d={:.2f}'.format(v, str_path, d))