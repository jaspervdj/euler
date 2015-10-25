#!/usr/bin/python3
import math

def square_root(n):
    s = int(math.sqrt(n))
    if s * s == n:
        return s
    else:
        return None

for a in range(1, 1000):
    for b in range(a + 1, 1000):
        c = square_root(a * a + b * b)
        if c and a + b + c == 1000:
            print(a * b * c)
