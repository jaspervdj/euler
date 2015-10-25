#!/usr/bin/python3
import primes

total = 0
sieve = primes.sieve(2000000)
for i, p in enumerate(sieve):
    if p: total += i

print(total)
