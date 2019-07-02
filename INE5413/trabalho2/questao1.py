from structures.grafo import GrafoD
from src.functions import *
from sys import argv
from os import path

if __name__ == '__main__':
    if len(argv) < 2 or argv[1] in ['-h', '--help']:
        print('Uso: python questao1.py <arquivo_descrevendo_grafo>')
        exit()

    filename = argv[1]
    if not path.isfile(filename):
        print('Arquivo não encontrado! [ {} ]'.format(filename))
        exit()

    g = GrafoD(filename)

    A = fortemente_conexas(g)

    # Transforma A em P, uma lista de proximos
    P = dict([(i+1, None) for i, v in enumerate(g.V)])
    for key in A.keys():
        if A[key] == None:
            continue

        P[A[key]] = key 

    C = dict([(i+1, False) for i, v in enumerate(g.V)])

    for u in C.keys():
        output = list()

        while not C[u]:
            C[u] = True
            output.append(u)

            if P[u] is None:
                break

            u = P[u]

        if len(output) > 1:
            # Formating output to print
            str_out = ','.join([str(i) for i in output])

            print(str_out)
