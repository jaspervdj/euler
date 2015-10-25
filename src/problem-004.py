#!/usr/bin/python3

def is_palindrome(string):
    i = 0
    j = len(string) - 1
    while(i < j):
        if string[i] != string[j]:
            return False
        else:
            i += 1
            j -= 1
    return True

maximum = 0

for x in range(100, 1000):
    for y in range(x, 1000):
        string = str(x * y)
        if is_palindrome(string) and x * y > maximum:
            maximum = x * y

print(maximum)
