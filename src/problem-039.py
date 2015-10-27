#!/usr/bin/env python3
import math

def square_root(n):
    s = int(math.sqrt(n))
    if s * s == n:
        return s
    else:
        return None

def triangulars(limit):
    for a in range(1, limit):
        for b in range(a, limit):
            c = square_root(a * a + b * b)
            if c and c < limit: yield a, b, c

perimeters = dict()
for a, b, c in triangulars(1000):
    p = a + b + c
    if p <= 1000:
        if p in perimeters:
            perimeters[p] += 1
        else:
            perimeters[p] = 1

def max_by_value(d):
    max_key = None
    max_value = None
    for k in d:
        if not max_value or d[k] > max_value:
            max_key = k
            max_value = d[k]
    return max_key

print(max_by_value(perimeters))
