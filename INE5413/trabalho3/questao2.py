#!/bin/python

from structures.grafo import GrafoNDP as Grafo
from src import functions
from sys import argv
from os import path

def main(filename):
    g = Grafo(filename)

    M = functions.hopcroft_karp(g)

    print(f'Flxuo máximo resultante pelo algoritmo de Hopcroft-Karp: {M[0]}')



if __name__ == '__main__':
    if len(argv) < 1 or argv[1] in ['-h', '--help']:
        print('Uso: python questao1.py <arquivo_descrevendo_grafo>')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()

    main(filename)