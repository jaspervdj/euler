#!/usr/bin/env python3

def read_names():
    with open("in/p022_names.txt") as f:
        return f.read().replace('"', '').split(',')

def alphabetical(c):
    return ord(c) - ord('A') + 1

def score(n, name):
    return n * sum(alphabetical(c) for c in name)

total = 0
for i, name in enumerate(sorted(read_names())):
    total += score(i + 1, name)

print(total)
