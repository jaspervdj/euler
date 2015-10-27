#!/usr/bin/env python3

def factorial(n):
    prod = n
    for i in range(1, n):
        prod *= i
    return prod

print(sum(int(c) for c in str(factorial(100))))
