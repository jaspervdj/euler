#!/usr/bin/env python3

def spiral(max_side):
    total = 1
    number = 1
    side = 1

    while side < max_side:
        side += 2
        for _ in range(0, 4):
            number += side - 1
            total += number

    return total

print(spiral(1001))
