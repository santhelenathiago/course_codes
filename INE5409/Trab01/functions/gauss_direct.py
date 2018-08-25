import numpy as np


def solve_gauss(A, b):
    '''
        @param A  input matrix
        @return   column-matrix solution of system
    '''
    n = len(A)  # n = dimension of A

    assert(n == b.shape[0])  # assert dimension of A with num of rows of b

    for op_row in range(n):
        for row in range(op_row+1, n):
            # multiplier calculated to zero element under operating row
            # to zero all elements under main diagonal
            multiplier = A[row, op_row]/A[op_row, op_row]

            # apply operation to b
            b[row, 0] = b[row, 0] - multiplier*b[op_row, 0]

            # apply operation to every column of row
            for col in range(n):
                A[row, col] = A[row, col] - multiplier*A[op_row, col]

    # x is column matriz with n rows
    x = np.zeros((n, 1))
    # iterate over reversed sequence from 0 to n-1
    for row in reversed(range(n)):
        amount = sum(A[row, col]*x[row, 0] for col in range(row, n))
        x[row, 0] = (b[row, 0] - amount)/A[row, row]

    return x
