#!/usr/bin/env python3

def sum_of_pow_digits(n, p):
    return sum(int(c) ** p for c in str(n))

total = 0
for n in range(2, 5 * 9 ** 5):
    if n == sum_of_pow_digits(n, 5):
        total += n
print(total)
