#!/bin/python

from structures.grafo_ponderado import Grafo
from src import functions
from sys import argv
from os import path
            
if __name__ == '__main__':
    if len(argv) < 2:
        print('Uso: python questao2.py <arquivo_descrevendo_grafo>')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()

    g = Grafo(filename)

    D, A = functions.bfs(g, 1)    
    f = 0
    while True:
        row = [k for k in D.keys() if D[k] == f]

        if row:
            row = str(row).replace('[', '').replace(']','').replace(' ', '')
            print('{}:{}'.format(str(f), row))
            f += 1
        else:
            break