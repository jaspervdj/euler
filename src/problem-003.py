#!/usr/bin/python3
import primes

def last(gen):
    x = None
    for y in gen: x = y
    return x

print(last(primes.factors(600851475143)))
