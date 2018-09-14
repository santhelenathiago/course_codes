import types
from math import tan, pi


def find_roots(function, beg, end, step):
    assert(isinstance(function, types.FunctionType))

    roots = set()
    limit = 5*step
    a = beg
    while a < end:
        b = a + step

        fA = function(a)
        fB = function(b)

        if fA*fB <= 0 and abs(fA) < limit and abs(fB) < limit:
            roots.add((a+b)/2)
        elif fA == 0:
            roots.add(a)
        elif fB == 0:
            roots.add(b)

        a = b

    return roots


def newton_linearization(function, x0, tolerance):
    assert(isinstance(function, types.FunctionType))
    assert(tolerance > 0)

    dx = 2*tolerance
    while (abs(dx) > tolerance):
        dx = -function(x0)*dx/(function(x0 + dx) - function(x0))
        x0 = x0+dx

    return x0


def func(x):
    return x*tan(x) - 1


if __name__ == '__main__':
    roots = find_roots(func, -3, 3, 0.1)
    print('Roots:', roots)
    corrected_roots = list()
    for root in roots:
        corrected_roots.append(newton_linearization(func, root, 10**(-8)))
    print('Roots linearized:', corrected_roots)
