import numpy as np


def solve_gauss_seidel(lamb, A, b, criteria, x=None):
    '''
        @param lamb lambda, relaxação
        @param A  coef matrix
        @param b  result matrix
        @param criteria stop criteria for max difference
               between old and new value
        @param x first values for method. Default is zero.
        @return   column-matrix solution of system
    '''
    assert(A.shape[0] == A.shape[1])

    n = len(A)

    if x is None:
        x = np.zeros(b.shape, dtype=np.float128)

    Di = np.zeros(b.shape)
    count = 0
    repeat = True
    while(1):
        count += 1
        for row in range(n):
            # avoid calc with 0 on coef
            amount = sum(A[row, col]*x[col, 0]
                         for col in range(n)
                         if A[row, col] != 0 and row != col)

            prev = x[row, 0]
            x[row, 0] = (b[row, 0] - amount)/A[row, row]

            x[row, 0] = (1 - lamb)*prev + lamb*x[row, 0]

            Di[row, 0] = abs(x[row, 0] - prev)

        # Finishes the loop if the max_Di find on iteration is smaller
        # than criteria
        max_Di = max(Di.reshape((1, n))[0])
        if (max_Di < criteria):
            break

    return (x, count)
