#!/usr/bin/env python3

exceptions = {
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
    16: "sixteen",
    17: "seventeen",
    18: "eighteen",
    19: "nineteen",
    20: "twenty",
    30: "thirty",
    40: "forty",
    50: "fifty",
    60: "sixty",
    70: "seventy",
    80: "eighty",
    90: "ninety"
}

def englishize(n):
    if n in exceptions:
        return exceptions[n]
    elif n % 1000 == 0:
        return englishize(n // 1000) + " thousand"
    elif n > 1000:
        return englishize(n // 1000) + " thousand " + englishize(n % 1000)
    elif n % 100 == 0:
        return englishize(n // 100) + " hundred"
    elif n > 100:
        return englishize(n // 100) + " hundred and " + englishize(n % 100)
    else:
        return englishize(10 * (n // 10)) + " " + englishize(n % 10)

def count_non_space_characters(string):
    return sum(1 for c in string if not c.isspace())

total = 0
for i in range(1, 1001):
    total += count_non_space_characters(englishize(i))
print(total)
