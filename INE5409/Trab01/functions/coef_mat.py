import numpy as np

# para  i = 1             x(i)+x(i+1) = 1.50

# para  i = 2: n/2        x(i-1)+4x(i)+x(i+1) = 1.00

# para  i = n/2+1: n-1    x(i-1)+5x(i)+x(i+1) = 2.00

# para  i = n             x(i-1)+x(i) = 3.00


def generate_mat(n):
    '''
        @param n: dimension of matrix
        @return described coef mat
    '''

    A = np.zeros((n, n))
    b = np.zeros((n, 1))

    # Line 0
    b[0, 0] = 1.5
    A[0, 0] = 1
    A[0, 1] = 1

    # Line from 1 to n/2
    for i in range(1, int(n/2)):
        b[i, 0] = 1.0
        A[i, i-1] = 1
        A[i, i] = 4
        A[i, i+1] = 1

    # Line from n/2 to n-1
    for i in range(int(n/2), n-1):
        b[i] = 2.0
        A[i, i-1] = 1
        A[i, i] = 5
        A[i, i+1] = 1

    # Line n-1
    b[n-1, 0] = 3.0
    A[n-1, n-2] = 1
    A[n-1, n-1] = 1

    return (A, b)
