#!/usr/bin/python3
import primes

primes_gen = primes.primes()

for i in range(1, 10001):
    next(primes_gen)

print(next(primes_gen))
