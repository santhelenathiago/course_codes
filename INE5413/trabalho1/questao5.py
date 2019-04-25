#!/bin/python

from structures.grafo_ponderado import Grafo
from src import functions
from sys import argv
from os import path

# Debuging option
DEBUG = False

if __name__ == '__main__':
    if len(argv) < 2 or argv[1] in ['-h', '--help']:
        print('Uso: python questao1.py <arquivo_descrevendo_grafo>')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()


    g = Grafo(filename)

    D = functions.floyd_warshall(g)

    for i, row in enumerate(D):
        distances = ''
        for e in row:
            distances += '{:.2f},'.format(e)
        
        # Printando até -1 para tirar a última vírgula
        print('{}:{}'.format(i+1, distances[:-1]))

        if DEBUG:
            for j, e in enumerate(row):
                print('{} -> {} = {:.2f}'.format(i+1, j+1, e))

            break
        