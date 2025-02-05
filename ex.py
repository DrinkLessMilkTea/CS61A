def repeat(f, n):
    if n == 0:
        return lambda x: x
    return lambda x: f(repeat(f, n - 1)(x))


def square(x):
    return x * x


square_2 = repeat(square, 2)

print(square_2(3))
