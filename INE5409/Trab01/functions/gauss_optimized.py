import numpy as np


def solve_gauss_optimized_tridiag(A, b):
    '''
        @param A  input matrix
        @param b  input results column
        @return   column-matrix solution of system
    '''

    n = len(A)  # n = dimension of A

    assert(n == b.shape[0])  # assert dimension of A with num of rows of b

    t = np.zeros(n)
    r = np.zeros(n)
    d = np.zeros(n)

    x = np.zeros((n, 1))

    # Init t
    t[0] = np.NaN
    for i in range(1, n):
        t[i] = A[i, i-1]

    # Init r
    for i in range(n):
        r[i] = A[i, i]

    # Init d
    for i in range(n-1):
        d[i] = A[i, i+1]
    d[n-1] = np.NaN

    # zero t
    for i in range(1, n):
        mult = t[i]/r[i-1]

        r[i] = r[i] - mult*d[i-1]

        b[i, 0] = b[i, 0] - mult*b[i-1, 0]

    # solve x
    x[n-1] = b[n-1]/r[n-1]

    for i in reversed(range(n-1)):
        x[i] = (b[i] - d[i]*x[i+1])/r[i]

    return x
