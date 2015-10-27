#!/usr/bin/env python3

def factorial(n):
    prod = n
    for i in range(1, n):
        prod *= i
    return prod

def combination(n, k):
    return factorial(n) // (factorial(k) * factorial(n - k))

print(combination(40, 20))
