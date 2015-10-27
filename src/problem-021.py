#!/usr/bin/env python3
import primes

def d(x):
    return sum(primes.proper_divisors(x))

amicable = set()
for a in range(1, 10000):
    if a not in amicable:
        b = d(a)
        if a != b and d(b) == a:
            amicable.add(a)
            amicable.add(b)

print(sum(amicable))
