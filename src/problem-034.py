#!/usr/bin/env python3

def factorial(n):
    if n == 0:
        return 1
    else:
        prod = n
        for i in range(1, n): prod *= i
        return prod

def sum_of_factorial_digits(n):
    return sum(factorial(int(c)) for c in str(n))

total = 0
for n in range(3, 100000):
    if n == sum_of_factorial_digits(n): total += n
print(total)
