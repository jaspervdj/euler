#!/usr/bin/env python3

def fibonacci():
    x = 1
    y = 2
    while True:
        yield x
        z = x + y
        x = y
        y = z

total = 0
gen = fibonacci()
i = next(gen)

while i <= 4000000:
    if i % 2 == 0: total += i
    i = next(gen)

print(total)
