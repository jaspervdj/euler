#!/usr/bin/python3

def sum_of_squares(n):
    total = 0
    for i in range(1, n + 1):
        total += i * i
    return total

def square_of_sum(n):
    total = sum(range(1, n + 1))
    return total * total

print(square_of_sum(100) - sum_of_squares(100))
