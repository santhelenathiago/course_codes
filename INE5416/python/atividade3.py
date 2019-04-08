print('Questão 1:')
x = bool(int(input('0 ou 1 para x:')))
y = bool(int(input('0 ou 1 para y:')))
print((lambda x, y: x != y)(x, y))


print('\n--------------------\n')
print('Questão 2:')
x = int(input('primeira nota:'))
y = int(input('segunda nota:'))
z = int(input('terceira nota:'))
print('media:', (lambda x, y, z: (x + y + z)/3)(x, y, z))

print('\n--------------------\n')
print('Questão 3:')
n = int(input('n:'))
print('n-esimo fib:', (lambda f1: lambda v1: f1(f1, v1)) (lambda f, x: 1 if x == 1 or x == 0 else f(f, x-2)+f(f, x-1)) (n))

print('\n--------------------\n')
print('Questão 4:')
a = int(input('a:'))
b = int(input('b:'))
c = int(input('c:'))
assert a != 0
print('raizes:', (lambda a, b, c: [(-b + (b**2 - 4 * a * c)**(1/2))/2*a, (-b - (b**2 - 4 * a * c)**(1/2))/2*a])(a, b, c))

print('\n--------------------\n')
print('Questão 5:')
x1 = int(input('x1:'))
y1 = int(input('y1:'))
z1 = int(input('z1:'))
x2 = int(input('x2:'))
y2 = int(input('y2:'))
z2 = int(input('z2:'))
p1 = [x1, y1, z1]
p2 = [x2, y2, z2]
d = (lambda p1, p2: ((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2 + (p1[2] - p2[2])**2)**(1/2))(p1, p2)
print('distância:', d)

print('\n--------------------\n')
print('Questão 6:')
a = int(input('a:'))
b = int(input('b:'))
c = int(input('c:'))
print('maior:', (lambda a, b, c, f: f(a, b) if f(a, b) > c else  c)(a, b, c, lambda a, b: a if a > b else b))

print('\n--------------------\n')
print('Questão 7:')
s = input('sequencia de numeros (separados por virgula):')
s = s.replace(' ', '')
l = [int(i) for i in s.split(',')]
print('paridades:', list(map((lambda a: 'par' if a%2 ==0 else 'impar'), l)))