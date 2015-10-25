#!/usr/bin/python3

def factors(n):
    i = 2
    while i <= n:
        if n % i == 0:
            yield i
            n = n / i
        else:
            i = i + 1

def last(gen):
    x = None
    for y in gen: x = y
    return x

print(last(factors(600851475143)))
