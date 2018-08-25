import numpy as np
from functions.LUdecomp import *
from functions.coef_mat import *
from functions.gauss_direct import *
from functions.residuo import *
from functions.dominance import *
from functions.gauss_seidel import *

if __name__ == '__main__':
    n = 50

    # Letra a
    print("########## Método LU de Crout ##########")
    A, b = generate_mat(n)
    x_crout = solve_LUCrout(A, b)

    print("a2):")
    print("Primeira: " + str(x_crout[0, 0]))
    print("ùltima: " + str(x_crout[n-1, 0]))

    # Numero de operações aritméticas
    op_num_crout = (4*(n**3) + 15*(n**2) - 7*n - 6)/6
    print("Número total de operações em ponto flutuante: " + str(op_num_crout))

    # Letra b
    print("\n########## Método de Gauss ##########\n")

    x_gauss = solve_gauss(A, b)
    print("b2):")
    print("Primeira: " + str(x_gauss[0, 0]))
    print("Última: " + str(x_gauss[n-1, 0]))
    max_resid = max(residual(A, b, x_gauss).reshape((1, n)).tolist()[0])
    print("Resíduo máximo: " + str(max_resid))

    op_num_gauss = (4 * (n**3) + 15 * (n**2) - n - 6)/6

    print("Número de operações: " + str(op_num_gauss))

    # Letra c
    criteria = 0.0001
    print("\n######### Teste de dominância da diagonal principal #########\n")
    print("c1):")
    dominacy = diag_dominant(A)
    strong_dominancy = strong_diag_dominant(A)

    if (strong_dominancy):
        print("A matriz de coeficientes tem a diagonal principal\n" +
              "fortemente dominante")

    elif (dominacy):
        print("A matriz de coeficientes tem a diagonal principal dominante")

    else:
        print("O sistema não tem diagonal dominante, portanto nada se pode\n" +
              "afirmar sobre sua convergência")
    if (strong_dominancy or dominacy):
        print("Como o sistema tem convergência garantida, um coeficiente\n" +
              "de relaxação pode ser utilizado para reduzir o número de \n" +
              "iterações")

    results = []
    print("\n######### Teste de coeficientes de relaxação #########\n")

    for i in range(1, 18):
        lamb = i/10

        print("\nTeste 1: lambda = " + str(lamb))
        iterative = solve_gauss_seidel(lamb, A, b, criteria)
        print("\nRepetições: " + str(iterative[1]))
        results.append((iterative[1], 1))

    print("\n########## Aplicação do método de Gauss-Seidel ##########\n")
    lamb = min(results, key=lambda k: k[0])[1]

    iterative = solve_gauss_seidel(lamb, A, b, criteria)
    max_resid_i = max(residual(A, b, iterative[0]).reshape((1, n)).tolist()[0])

    print("c3):")
    print("Lambda utilizado: " + str(lamb))
    print("Primeira: " + str(iterative[0][0, 0]))
    print("Última: " + str(iterative[0][n-1, 0]))
    print("Resíduo máximo: " + str(max_resid_i))

    op_num_iterative = iterative[1]*(5 + ((n-2)*8) + 5 + n)

    print("c4):")
    print("Iterações: " + str(iterative[1]))
    print("Número de operações em ponto flutuante: " +
          str((float(op_num_iterative))))

    better_iterative = solve_gauss_seidel(
        lamb, A, b, criteria**2, iterative[0].copy())

    truncamento = max(
        abs(iterative[0] - better_iterative[0]).reshape((1, n)).tolist()[0])

    print("Erro máximo de truncamento: {0:.16f}".format(truncamento))

    print("\n########## Número de operações em ponto flutuante ##########\n")
    print("Método de decomposição LU de Crout: " + str(op_num_crout))
    print("Método direto de Gauss: " + str(op_num_gauss))
    print("Método iterativo de Gauss-Seidel: " + str(float(op_num_iterative)))
