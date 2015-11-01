#!/usr/bin/env python3

def read_triangle():
    with open("in/p067_triangle.txt") as f:
        lines = f.read().strip().splitlines()
        triangle = []
        for line in lines:
            row = list(map(int, line.split()))
            triangle.append(row)
        return triangle

def max_path(triangle):
    # Reverse row indices starting from the second to last row
    for r in range(len(triangle) - 2, -1, -1):
        for c in range(0, len(triangle[r])):
            below = max(triangle[r + 1][c], triangle[r + 1][c + 1])
            triangle[r][c] = triangle[r][c] + below
    return triangle[0][0]

print(max_path(read_triangle()))
