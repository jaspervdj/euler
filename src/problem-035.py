#!/usr/bin/env python3
import primes

limit = 1000000
sieve = primes.sieve(limit)

def is_prime(n):
    return sieve[n]

def rotations(string):
    return (string[i :] + string[: i] for i in range(len(string)))

def all_rotations_are_prime(n):
    for rot in rotations(str(n)):
        if not is_prime(int(rot)): return False
    return True

found = set()
for n in range(1, limit):
    if all_rotations_are_prime(n):
        found.add(n)

print(len(found))
