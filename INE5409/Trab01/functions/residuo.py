import numpy as np


def residual(A, b, x):
    '''
        @param A coeficients matrix
        @param b consts matrix
        @param x solution matrix

        @return column-matrix with residual for each line
    '''
    n = len(A)
    r = np.zeros(x.shape, dtype=np.float128)
    assert(n == r.shape[0])
    assert(b.shape == x.shape)

    for row in range(n):
        r[row, 0] = b[row, 0] - sum(A[row, col] * x[row, 0]
                                    for col in range(n))

    return r
