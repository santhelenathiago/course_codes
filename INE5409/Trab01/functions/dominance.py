import numpy as np


def diag_dominant(A):
    assert(A.shape[0] == A.shape[1])

    # |aii| >= Zi for all i in 1 .. n
    a = True
    # |aii| > Zi for any i in 1 .. n
    b = False
    n = len(A)
    for i in range(n):

        # check if
        amount = sum(A[i, j] for j in range(n) if j != i)
        if A[i, i] < amount:
            a = False

        if A[i, i] > amount:
            b = True

    return a and b


def strong_diag_dominant(A):
    assert(A.shape[0] == A.shape[1])

    # |aii| > Zi for all i in 1 .. n
    a = True

    n = len(A)
    for i in range(n):

        # check if
        amount = sum(A[i, j] for j in range(n) if j != i)
        if A[i, i] <= amount:
            a = False

    return a
