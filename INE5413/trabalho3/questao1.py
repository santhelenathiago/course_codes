#!/bin/python

from structures.grafo import GrafoD as Grafo
from src import functions
from sys import argv
from os import path

def main(filename):
    g = Grafo(filename, not_connected=0)

    source = g.s
    sink = g.t

    m = functions.edmonds_karp(g, source, sink)

    print(f'O fluxo máximo entre os vértices {source} e {sink} é {m}')


if __name__ == '__main__':
    if len(argv) < 2 or argv[1] in ['-h', '--help']:
        print('Uso: python questao1.py <arquivo_descrevendo_grafo>')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()

    main(filename)