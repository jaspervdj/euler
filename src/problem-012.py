#!/usr/bin/python3
import primes

def triangle_numbers():
    number = 1
    increment = 2
    while True:
        yield number
        number += increment
        increment += 1

def num_divisors(n):
    return sum(1 for _ in primes.divisors(n))

for n in triangle_numbers():
    if num_divisors(n) > 500:
        print(n)
        break
