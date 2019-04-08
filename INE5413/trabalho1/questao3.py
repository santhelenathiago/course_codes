#!/bin/python

from structures.grafo_ponderado import Grafo
from src import functions
from sys import argv
from os import path
            
if __name__ == '__main__':
    if len(argv) < 2:
        print('Uso: python questao1.py <arquivo_descrevendo_grafo>')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()

    g = Grafo(filename)

    r, cicle = functions.hierholzer(g)

    if not r:
        print(0)

    else:
        print(1)
        print(str(cicle)[1:-1].replace(' ', ''))

    