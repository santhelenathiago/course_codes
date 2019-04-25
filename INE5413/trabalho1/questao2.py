#!/bin/python

from structures.grafo_ponderado import Grafo
from src import functions
from sys import argv
from os import path
            
if __name__ == '__main__':
    if len(argv) < 3 or argv[1] in ['-h', '--help']:
        print('Uso: python questao1.py <arquivo_descrevendo_grafo> <vertice>')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()

    v = int(argv[2])

    g = Grafo(filename)

    D, A = functions.bfs(g, v)    
    f = 0
    while True:
        row = [k for k in D.keys() if D[k] == f]

        if row:
            row = str(row).replace('[', '').replace(']','').replace(' ', '')
            print('{}:{}'.format(str(f), row))
            f += 1
        else:
            break