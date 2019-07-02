# 

values = dict()
values[0] = 0
values[1] = 1

def fib(n):
    if n in values.keys():
        return values[n]
    
    f = fib(n-1) + fib(n-2)
    values[n] = f
    return f

def fib2(n):
    for i in range(n):
        fib(i)

    return fib(n)
