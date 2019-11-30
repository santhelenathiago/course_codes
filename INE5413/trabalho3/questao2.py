#!/bin/python

from structures.grafo import GrafoNDP as Grafo
from src import functions
from sys import argv
from os import path

def main(filename, show_pairs):
    g = Grafo(filename)

    M, mate = functions.hopcroft_karp(g)

    pairs = []
    done_keys = []
    for k in mate:
        if k not in done_keys:
            pairs.append((k, mate[k]))
            done_keys.append(k)
            done_keys.append(mate[k])
        

    print(f'O emparelhamento máximo pelo algoritmo de Hopcroft-Karp: {M}')
    if show_pairs:
        print('Pares: ')
        for p in pairs:
            print(p)



if __name__ == '__main__':
    if len(argv) < 2 or argv[1] in ['-h', '--help']:
        print('Uso: python questao1.py <arquivo_descrevendo_grafo>')
        print('-h para help, -s para show_graphs')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()

    show_graphs = '-s' in argv

    main(filename, show_graphs)