#!/usr/bin/env python3

def t(n):
    return n * (n + 1) // 2

triangle_numbers = set()
for n in range(1, 10000):
    triangle_numbers.add(t(n))

def sum_of_chars(string):
    return sum (ord(c) - ord('A') + 1 for c in string)

def is_triangle_word(w):
    return sum_of_chars(w) in triangle_numbers

def read_words():
    with open('in/p042_words.txt') as f:
        return f.read().replace('"', '').split(',')

total = 0
for word in read_words():
    if is_triangle_word(word): total += 1
print(total)
