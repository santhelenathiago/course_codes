import numpy as np


def LUdecomp(A):
    '''
        @param A  input matrix
        @return   (L, U) decomposition of A
    '''
    n = len(A)

    # Crout
    U = np.zeros(A.shape)
    for i in range(n):
        U[i, i] = 1

    L = np.zeros(A.shape)

    k = 0
    for i in range(n):
        L[i, k] = A[i, 0]

    for j in range(1, n):
        U[0, j] = A[0, j]/L[0, 0]

    for k in range(1, n-1):
        for i in range(k, n):
            tmp = sum([L[i, r] * U[r, k] for r in range(k)])
            L[i, k] = A[i, k] - tmp

        for j in range(k+1, n):
            tmp = sum([L[k, r] * U[r, j] for r in range(k)])
            U[k, j] = (A[k, j] - tmp)/L[k, k]

    k = n-1
    L[k, k] = A[k, k] - sum([L[k, r] * U[r, k] for r in range(k)])

    return [L, U]


def solve_LUCrout(A, b):
    '''
        @param A  coeficients matrix
        @param b  results matrix

        @return column-matrix solution
    '''
    n = len(A)  # n = rows of A
    x = np.zeros((n, 1))
    c = np.zeros((n, 1))

    L, U = LUdecomp(A)
    # Ax = b
    # A = L*U
    # L*U*x = b
    # U*x = c
    # L*c = b

    # Solve c
    c[0, 0] = b[0, 0]/L[0, 0]

    for i in range(1, n):
        tmp = sum(L[i, j]*c[j, 0] for j in range(0, i))
        c[i, 0] = (b[i, 0] - tmp)/L[i, i]

    # Solve x
    x[n-1, 0] = c[n-1, 0]
    for i in reversed(range(0, n-1)):
        tmp = sum(U[i, j]*x[j, 0] for j in range(i, n))

        x[i, 0] = c[i, 0] - tmp

    return x


if __name__ == '__main__':
    A = [[1, 2, 3],
         [3, 2, 1],
         [4, 5, 7]]

    b = [[1],
         [3],
         [6]]

    A = np.array(A)
    b = np.array(b)

    L, U = LUdecomp(A)

    LU = L.dot(U)

    print("L:")
    print(L)

    print("U:")
    print(U)

    print("A:")
    print(A)

    print("b:")
    print(b)

    print("L*U:")
    print(LU)

    x = solve(A, b)

    print("x:")
    print(x)
